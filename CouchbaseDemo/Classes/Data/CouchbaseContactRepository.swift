//
//  CouchbaseContactRepository.swift
//  CouchbaseDemo
//
//  Created by Damiano Giusti on 05/02/2020.
//

import CouchbaseLiteSwift
import Foundation

class CouchbaseContactsRepository: ContactsRepository, SyncManager {
    
    static let instance: CouchbaseContactsRepository = CouchbaseContactsRepository()

    // MARK: ContactsRepository
    
    func getAllContacts(callback: @escaping (ContactsResult<[Contact]>) -> ()) -> Disposable {
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property(Type).equalTo(Expression.string(contactType)))

        let token = query.addChangeListener { [weak self] queryChange in
            let contacts = queryChange.results?
                .allResults()
                .compactMap { $0.toDictionary()[DatabaseName] }
                .compactMap { dict -> Contact? in
                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                        return try? self?.decoder.decode(Contact.self, from: jsonData)
                    } else {
                        return nil
                    }
                } ?? []

            callback(.success(contacts))
        }
        
        return Disposable(query: query, token: token)
    }
    
    func getContact(byId contactId: String, callback: @escaping (ContactsResult<Contact>) -> ()) {
        if let documentDictionary = database.document(withID: contactId)?.toDictionary() {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: documentDictionary, options: [])
                let contact = try decoder.decode(Contact.self, from: jsonData)
                callback(.success(contact))
            } catch {
                callback(.failure(.errorGettingContact(error)))
            }
        } else {
            callback(.failure(.errorInvalidContact))
        }
    }
    
    func save(contact: Contact, callback: @escaping (ContactsResult<Contact>) -> ()) {
        if let jsonData = try? encoder.encode(contact),
            let data = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            let doc = MutableDocument(id: contact.id, data: data)
            doc.setString(contactType, forKey: Type)
            do {
                try database.saveDocument(doc)
                callback(.success(contact))
            } catch {
                callback(.failure(.errorSavingContact(error)))
            }
        } else {
            callback(.failure(.errorInvalidContact))
        }
    }
    
    func delete(contact contactId: String, callback: @escaping (ContactsResult<Void>) -> ()) {
        if let doc = database.document(withID: contactId) {
            do {
                try database.deleteDocument(doc)
                callback(.success(()))
            } catch {
                callback(.failure(.errorDeletingContact(error)))
            }
        } else {
            callback(.failure(.errorContactNotFound))
        }
    }
    
    // MARK: SyncManager
    
    func startSync() {
        let targetEndpoint = URLEndpoint(url: URL(string: RemoteDatabaseURL)!)

        let replConfig = ReplicatorConfiguration(database: database, target: targetEndpoint)
        replConfig.replicatorType = .pushAndPull
        replConfig.continuous = true
        replConfig.authenticator = BasicAuthenticator(username: Username, password: Password)

        replicator = Replicator(config: replConfig)
        replicator?.start()
        
        listenerToken = replicator?.addChangeListener { (change) in
            if let error = change.status.error as NSError? {
                print("Error code :: \(error.code)")
            }
        }
    }
    
    func stopSync() {
        listenerToken.flatMap { replicator?.removeChangeListener(withToken: $0) }
        replicator?.stop()
        replicator = nil
    }
    
    // MARK: Private properties
    
    private lazy var database: Database = {
        do {
            return try Database(name: DatabaseName)
        } catch {
            fatalError("Error opening database")
        }
    }()
    
    private var replicator: Replicator?
    private var listenerToken: ListenerToken?
    
    private let contactType = "Contact"
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
}

//
//  ContactsViewModel.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

class ContactsViewModel {

    init() {
        /// STEP 5
        /// Init database with database name.
//        do {
//            database = try Database(name: DatabaseName)
//        } catch {
//            fatalError("Error opening database")
//        }
    }

    deinit {
        disposable?.dispose()
    }

    // MARK: - Public properties

    /// STEP 3
    /// Declare contacts array and init it empty.
//    var contacts: [Contact] = []

    // MARK: - Public funtions

    /// STEP 6
    /// LoadData function to retrieve all contacts from database.
//    func loadData(completion: @escaping () -> Void) {
//
        /// STEP 7
        /// Define database query to retrieve all documents having "Contact" as value of field "type".
//        let query = QueryBuilder
//            .select(SelectResult.all())
//            .from(DataSource.database(database))
//            .where(Expression.property(Type).equalTo(Expression.string(String(describing: Contact.self))))
//
        /// STEP 8
        /// Execute the query and subscribe to every changes of datasource.
        /// Add query and token to a disposable object to unsubscribe when ViewModel will be disposed.
//        let token = query.addChangeListener { [weak self] queryChange in
//            self?.contacts = queryChange.results?
//                .allResults()
//                .compactMap { $0.toDictionary()[DatabaseName] }
//                .compactMap { dict -> Contact? in
//                    guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
//                        else { return nil }
//                    return try? JSONDecoder().decode(Contact.self, from: jsonData)
//                } ?? []
//
//            completion()
//        }
//
//        disposable = Disposable(query: query, token: token)
//    }

    /// STEP 37
    /// Delete contact function to delete a contact from database with its id.
//    func deleteContact(contactId: String, callback: (_ success: Bool) -> Void) {
//
        /// STEP 38
        /// Retrieve document with id, delete it with properly database function and then update datasource.
//        guard let doc = database.document(withID: contactId)
//            else {
//                callback(false)
//                return
//        }
//
//        do {
//            try database.deleteDocument(doc)
//            contacts.removeAll(where: { $0.id == contactId })
//            callback(true)
//        } catch {
//            callback(false)
//        }
//
//    }

    /// STEP 14
    /// Utilities functions to retrieve phone number and name surname from Contact object.
//    func makePhoneNumber(contact: Contact) -> String {
//        return contact.phoneNumber ?? "No phone number"
//    }
//
//    func makeNameSurname(contact: Contact) -> String {
//        let nameSurname = [contact.name, contact.surname]
//            .lazy
//            .compactMap { $0 }
//            .joined(separator: " ")
//
//        return nameSurname.isEmpty ? "No name" : nameSurname
//    }

    // MARK: - Private properties

    /// STEP 4
    /// Declare database variable
//    private let database: Database

    private var disposable: Disposable?
}

class Disposable {

    init(query: Query, token: ListenerToken) {
        self.query = query
        self.token = token
    }

    func dispose() {
        query.removeChangeListener(withToken: token)
    }

    private let query: Query
    private let token: ListenerToken
}

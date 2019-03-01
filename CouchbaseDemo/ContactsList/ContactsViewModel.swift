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
        // STEP 5
        do {
            database = try Database(name: DatabaseName)
        } catch {
            fatalError("Error opening database")
        }
    }

    deinit {
        disposable?.dispose()
    }

    // MARK: - Public properties

    // STEP 3
    var contacts: [Contact] = []

    // MARK: - Public funtions

    // STEP 6, STEP 7, STEP 8
    func loadData(completion: @escaping () -> Void) {
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property(Type).equalTo(Expression.string(String(describing: Contact.self))))

        let token = query.addChangeListener { [weak self] queryChange in
            self?.contacts = queryChange.results?
                .allResults()
                .compactMap { $0.toDictionary()[DatabaseName] }
                .compactMap { dict -> Contact? in
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
                        else { return nil }
                    return try? JSONDecoder().decode(Contact.self, from: jsonData)
                } ?? []

            completion()
        }

        disposable = Disposable(query: query, token: token)
    }

    // STEP 37, STEP 38
    func deleteContact(contactId: String, callback: (_ success: Bool) -> Void) {
        // STEP 38
        guard let doc = database.document(withID: contactId)
            else {
                callback(false)
                return
        }

        do {
            try database.deleteDocument(doc)
            contacts.removeAll(where: { $0.id == contactId })
            callback(true)
        } catch {
            callback(false)
        }

    }

    // STEP 14
    func makePhoneNumber(contact: Contact) -> String {
        return contact.phoneNumber ?? "No phone number"
    }

    func makeNameSurname(contact: Contact) -> String {
        let nameSurname = [contact.name, contact.surname]
            .lazy
            .compactMap { $0 }
            .joined(separator: " ")

        return nameSurname.isEmpty ? "No name" : nameSurname
    }

    // MARK: - Private properties

    // STEP 4
    private let database: Database

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

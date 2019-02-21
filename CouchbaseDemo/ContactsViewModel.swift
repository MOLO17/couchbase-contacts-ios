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
        do {
            database = try Database(name: DatabaseName)
        } catch {
            fatalError("Error opening database")
        }
    }

    // MARK: - Public properties

    var contacts: [Contact] = []

    // MARK: - Public funtions

    func loadData(completion: @escaping () -> Void) {

        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property(Type).equalTo(Expression.string(String(describing: Contact.self))))

        query.addChangeListener { [weak self] queryChange in
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
    }

    func deleteContact(contactId: String, callback: (_ success: Bool) -> Void) {
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

    func makePhoneNumber(contact: Contact) -> String {
        return contact.phoneNumber ?? "No phone number"
    }

    func makeNameSurname(contact: Contact) -> String {
        if contact.name == nil && contact.surname == nil {
            return "No name"
        } else {
            let name = contact.name ?? ""
            let surname = contact.surname ?? ""

            return "\(name) \(surname)".trimmingCharacters(in: CharacterSet())
        }
    }

    func makeNameSurname2(contact: Contact) -> String {
        let nameSurname = [contact.name, contact.surname]
            .lazy
            .compactMap { $0 }
            .joined(separator: " ")

        return nameSurname.isEmpty ? "No name" : nameSurname
    }

    // MARK: - Private properties

    private let database: Database
}

//
//  NewContactViewModel.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

class NewContactViewModel {

    init() {
        // STEP 19
        do {
            database = try Database(name: DatabaseName)
        } catch {
            fatalError("Error opening database")
        }
    }

    // MARK: - Public funtions

    // STEP 20, STEP 21, STEP 22
    func saveContact(
        name: String?,
        surname: String?,
        phoneNumber: String?,
        email: String?,
        callback: (_ success: Bool) -> Void
    ) {
        let contact = Contact(
            id: UUID().uuidString,
            name: name,
            surname: surname,
            phoneNumber: phoneNumber,
            email: email
        )

        guard let jsonData = try? JSONEncoder().encode(contact),
            let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            else { return }

        let doc = MutableDocument(id: contact.id, data: dict)
        doc.setString(String(describing: Contact.self), forKey: Type)

        do {
            try database.saveDocument(doc)
            callback(true)
        } catch {
            callback(false)
        }

    }

    // MARK: - Private properties

    // STEP 18
    private let database: Database
}

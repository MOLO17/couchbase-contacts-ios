//
//  ContactDetailViewModel.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

class ContactDetailViewModel {

    init() {
        // STEP 27
//        do {
//            database = try Database(name: DatabaseName)
//        } catch {
//            fatalError("Error opening database")
//        }
    }

    // MARK: - Public funtions

    // STEP 28
//    func getContact(by id: String, callback: @escaping (Contact?) -> Void) {
//
//        // STEP 29
////        guard let dict = database.document(withID: id)?.toDictionary(),
////            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
////            else {
////                callback(nil)
////                return
////        }
////
////        let contact = try? JSONDecoder().decode(Contact.self, from: jsonData)
////        callback(contact)
//    }

    // STEP 33
//    func editContact(
//        id: String,
//        name: String?,
//        surname: String?,
//        phoneNumber: String?,
//        email: String?,
//        callback: () -> Void
//    ) {
//        // STEP 34
////        let contact = Contact(
////            id: id,
////            name: name,
////            surname: surname,
////            phoneNumber: phoneNumber,
////            email: email
////        )
//
//        // STEP 35
////        guard let jsonData = try? JSONEncoder().encode(contact),
////            let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
////            else { return }
////
////        let doc = MutableDocument(id: contact.id, data: dict)
////        doc.setString(String(describing: Contact.self), forKey: Type)
////
////        try? database.saveDocument(doc)
//
//        callback()
//    }

    // MARK: - Private properties

    // STEP 26
//    private let database: Database
}

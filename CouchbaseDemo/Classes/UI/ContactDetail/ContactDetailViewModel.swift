//
//  ContactDetailViewModel.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

enum ContactDetailType {
    case create
    case edit(_ contactId: String)
}

class ContactDetailViewModel {

    init(
        type: ContactDetailType,
        contactsRepository: ContactsRepository
    ) {
        self.type = type
        self.contactsRepository = contactsRepository
    }

    // MARK: - Public funtions

    func getContact(callback: @escaping (Contact) -> ()) {
        guard case let .edit(contactId) = type else { return }

        contactsRepository.getContact(byId: contactId) { result in
            switch result {
            case .success(let contact):
                callback(contact)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    func saveContact(
        name: String?,
        surname: String?,
        phoneNumber: String?,
        email: String?,
        callback: @escaping () -> Void
    ) {
        let id: String
        switch type {
        case .create:
            id = UUID().uuidString
        case .edit(let contactId):
            id = contactId
        }

        let contact = makeContact(id: id, name: name, surname: surname, phoneNumber: phoneNumber, email: email)

        contactsRepository.save(contact: contact) { result in
            switch result {
            case .success:
                callback()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    // MARK: - Private properties

    private let type: ContactDetailType
    private let contactsRepository: ContactsRepository
}

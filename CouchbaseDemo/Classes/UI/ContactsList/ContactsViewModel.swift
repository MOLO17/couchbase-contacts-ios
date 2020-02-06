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

    init(
        contactsRepository: ContactsRepository
    ) {
        self.contactsRepository = contactsRepository
    }

    deinit {
        disposable?.dispose()
    }

    // MARK: - Public properties

    private(set) var contacts: [UiContact] = []

    // MARK: - Public funtions

    func loadData(contactsDidUpdate: @escaping () -> Void) {
        disposable = contactsRepository.getAllContacts { [weak self] result in
            switch result {
            case .success(let contacts):
                self?.contacts = self?.makeUiContacts(from: contacts) ?? []
                contactsDidUpdate()
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func deleteContact(contactId: String, callback: (() -> Void)? = nil) {

        contactsRepository.delete(contact: contactId) { result in
            switch result {
            case .success:
                callback?()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func makeUiContacts(from contacts: [Contact]) -> [UiContact] {
        contacts.map { contact in
            UiContact(
                identifier: contact.id,
                displayName: makeNameSurname(contact: contact),
                phoneNumber: makePhoneNumber(contact: contact)
            )
        }
    }
    
    private func makePhoneNumber(contact: Contact) -> String {
        return contact.phoneNumber ?? "No phone number"
    }

    private func makeNameSurname(contact: Contact) -> String {
        let nameSurname = [contact.name, contact.surname].compactMap { $0 }.joined(separator: " ")
        return nameSurname.isEmpty ? "No name" : nameSurname
    }

    // MARK: - Private properties

    private let contactsRepository: ContactsRepository

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

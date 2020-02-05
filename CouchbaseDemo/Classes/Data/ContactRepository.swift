//
//  ContactRepository.swift
//  CouchbaseDemo
//
//  Created by Damiano Giusti on 05/02/2020.
//

import Foundation

enum ContactsRepositoryError: Error {
    case errorGettingContact(Error)
    case errorSavingContact(Error)
    case errorDeletingContact(Error)
    case errorInvalidContact
    case errorContactNotFound
}

typealias ContactsResult<T> = Result<T, ContactsRepositoryError>

protocol ContactsRepository {
    func getAllContacts(callback: @escaping (ContactsResult<[Contact]>) -> ()) -> Disposable
    func getContact(byId contactId: String, callback: @escaping (ContactsResult<Contact>) -> ())
    func save(contact: Contact, callback: @escaping (ContactsResult<Contact>) -> ())
    func delete(contact contactId: String, callback: @escaping (ContactsResult<Void>) -> ())
}

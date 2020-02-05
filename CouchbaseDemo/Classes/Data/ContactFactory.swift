//
//  ContactFactory.swift
//  CouchbaseDemo
//
//  Created by Damiano Giusti on 05/02/2020.
//

import Foundation

func makeContact(
    id: String,
    name: String?,
    surname: String?,
    phoneNumber: String?,
    email: String?
) -> Contact {
    let name = name == "" ? nil : name
    let surname = surname == "" ? nil : surname
    let phoneNumber = phoneNumber == "" ? nil : phoneNumber
    let email = email == "" ? nil : email
    
    return Contact(
        id: id,
        name: name,
        surname: surname,
        phoneNumber: phoneNumber,
        email: email
    )
}

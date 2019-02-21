//
//  Contact.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation

// STEP 1
struct Contact: Codable {
    var id: String
    var name: String?
    var surname: String?
    var phoneNumber: String?
    var email: String?
}

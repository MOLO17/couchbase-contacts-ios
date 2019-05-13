//
//  ContactDetailViewController.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet var editButton: UIBarButtonItem?
    @IBOutlet var saveButton: UIBarButtonItem?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField?
    @IBOutlet weak var phoneNumberTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?

    @IBAction func editButtonPressed() {
        editMode = !editMode
    }

    @IBAction func saveButtonPressed() {
        /// STEP 36
        /// Retrieve data from the views, check nullability and invoke editContact function.
//        guard let id = contactId else { return }
//        let name = nameTextField?.text == "" ? nil : nameTextField?.text
//        let surname = surnameTextField?.text == "" ? nil : surnameTextField?.text
//        let phoneNumber = phoneNumberTextField?.text == "" ? nil : phoneNumberTextField?.text
//        let email = emailTextField?.text == "" ? nil : emailTextField?.text
//
//        viewModel.editContact(
//            id: id,
//            name: name,
//            surname: surname,
//            phoneNumber: phoneNumber,
//            email: email
//        ) { [weak self] in
//            self?.navigationController?.popViewController(animated: true)
//        }

    }

    /// STEP 24
    /// Declare contactId variable
//    var contactId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Detail"

        /// STEP 30
        /// Check if contactId is nil, otherwise retrieve Contact data using getContactById function, and then fill in the fields.
//        if let id = contactId {
//            viewModel.getContact(by: id) { [weak self] contact in
//                guard let contact = contact else { return }
//
//                self?.nameTextField?.text = contact.name
//                self?.surnameTextField?.text = contact.surname
//                self?.phoneNumberTextField?.text = contact.phoneNumber
//                self?.emailTextField?.text = contact.email
//            }
//        }
    }

    private var editMode: Bool = false {
        didSet {
            nameTextField?.isEnabled = editMode
            surnameTextField?.isEnabled = editMode
            phoneNumberTextField?.isEnabled = editMode
            emailTextField?.isEnabled = editMode
        }
    }

    /// STEP 25
    /// Declare viewModel variable and init it lazily.
//    private lazy var viewModel = ContactDetailViewModel()
}

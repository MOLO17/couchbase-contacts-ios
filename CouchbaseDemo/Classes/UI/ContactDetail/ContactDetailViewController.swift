//
//  ContactDetailViewController.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var saveButton: UIBarButtonItem!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    var type: ContactDetailType?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Detail"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getContact() { [weak self] contact in
            self?.didReceive(contact: contact)
        }
    }
    
    @IBAction func editButtonPressed() {
        editMode = !editMode
    }

    @IBAction func saveButtonPressed() {
        viewModel.saveContact(
            name: nameTextField?.text,
            surname: surnameTextField?.text,
            phoneNumber: phoneNumberTextField?.text,
            email: emailTextField?.text
        ) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    // MARK: Private methods
    
    private func didReceive(contact: Contact) {
        nameTextField.text = contact.name
        surnameTextField.text = contact.surname
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
    }

    // MARK: Private properties
    
    private var editMode: Bool = false {
        didSet {
            nameTextField?.isEnabled = editMode
            surnameTextField?.isEnabled = editMode
            phoneNumberTextField?.isEnabled = editMode
            emailTextField?.isEnabled = editMode
        }
    }

    private lazy var viewModel: ContactDetailViewModel = {
        guard let type = self.type else {
            fatalError("Cannot launch contact detail without a type!")
        }
        return ContactDetailViewModel(type: type, contactsRepository: CouchbaseContactsRepository.instance)
    }()
}

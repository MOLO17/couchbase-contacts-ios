//
//  NewContactViewController.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Contact"
    }
    
    // MARK: - Private properties
    
    private lazy var viewModel = ContactDetailViewModel(type: .create, contactsRepository: CouchbaseContactsRepository.instance)
}

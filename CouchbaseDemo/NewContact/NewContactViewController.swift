//
//  NewContactViewController.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var surnameTextField: UITextField?
    @IBOutlet weak var phoneNumberTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?

    @IBAction func saveButtonPressed() {
        /// STEP 23
        /// Retrieve data from the views, check nullability and invoke saveContact function.
//        let name = nameTextField?.text == "" ? nil : nameTextField?.text
//        let surname = surnameTextField?.text == "" ? nil : surnameTextField?.text
//        let phoneNumber = phoneNumberTextField?.text == "" ? nil : phoneNumberTextField?.text
//        let email = emailTextField?.text == "" ? nil : emailTextField?.text
//
//        viewModel.saveContact(
//            name: name,
//            surname: surname,
//            phoneNumber: phoneNumber,
//            email: email
//        ) { [weak self] success in
//            if success {
//                self?.navigationController?.popViewController(animated: true)
//            }
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Contact"
    }

    // MARK: - Private properties

    /// STEP 17
    /// Declare viewModel variable and init it lazily.
//    private lazy var viewModel = NewContactViewModel()
}

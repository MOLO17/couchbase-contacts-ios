//
//  ViewController.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 20/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    // MARK: - Public properties

    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"

        // STEP 16
//        tableView?.delegate = self
//        tableView?.dataSource = self

        loadData()
    }

    // MARK: - Private properties

    // STEP 9
    private func loadData() {
//        viewModel.loadData { [weak self] in
//            self?.tableView?.reloadData()
//        }
    }

    // STEP 31
    fileprivate func navigateToDetail(contactId: String) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController {
//            vc.contactId = contactId
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }

    // MARK: - Private properties

    // STEP 2
//    private lazy var viewModel = ContactsViewModel()

    private static let reuseIdentifier = "ContactsTableViewCellReuseIdentifier"
}

// STEP 10
//extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // STEP 11
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 1
////    }
//
//    // STEP 12
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return viewModel.contacts.count
////    }
//
//    // STEP 13
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: ContactsViewController.reuseIdentifier)
////
////        // STEP 15
//////        let contact = viewModel.contacts[indexPath.row]
//////
//////        cell.textLabel?.text = viewModel.makeNameSurname(contact: contact)
//////        cell.detailTextLabel?.text = viewModel.makePhoneNumber(contact: contact)
////
////        return cell
////    }
//
//    // STEP 32
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let contactId = viewModel.contacts[indexPath.row].id
////        navigateToDetail(contactId: contactId)
////    }
//
//    // STEP 39
////    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        guard editingStyle == .delete else { return }
////
////        let contactId = viewModel.contacts[indexPath.row].id
////        viewModel.deleteContact(contactId: contactId) { success in
////            if success {
////                tableView.deleteRows(at: [indexPath], with: .fade)
////            }
////        }
////    }
//
//}


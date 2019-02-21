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

        tableView?.delegate = self
        tableView?.dataSource = self

        loadData()
    }

    // MARK: - Private properties

    private func loadData() {
        viewModel.loadData { [weak self] in
            self?.tableView?.reloadData()
        }
    }

    fileprivate func navigateToDetail(contactId: String) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController {
            vc.contactId = contactId
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Private properties

    private lazy var viewModel = ContactsViewModel()

    private static let reuseIdentifier = "ContactsTableViewCellReuseIdentifier"
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: ContactsViewController.reuseIdentifier)

        let contact = viewModel.contacts[indexPath.row]

        cell.textLabel?.text = viewModel.makeNameSurname(contact: contact)
        cell.detailTextLabel?.text = viewModel.makePhoneNumber(contact: contact)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactId = viewModel.contacts[indexPath.row].id
        navigateToDetail(contactId: contactId)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let contactId = viewModel.contacts[indexPath.row].id
        viewModel.deleteContact(contactId: contactId) { success in
            if success {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

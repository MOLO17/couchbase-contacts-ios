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

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"

        tableView?.delegate = self
        tableView?.dataSource = self

        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // MARK: - Private methods

    private func loadData() {
        viewModel.loadData { [weak self] in
            self?.tableView.reloadData()
        }
    }

    fileprivate func navigateToDetail(contactId: String) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController {
            vc.type = .edit(contactId)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Private properties

    private lazy var viewModel = ContactsViewModel(contactsRepository: CouchbaseContactsRepository.instance)

    private static let reuseIdentifier = "ContactsTableViewCellReuseIdentifier"
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: ContactsViewController.reuseIdentifier)

        let contact = viewModel.contacts[indexPath.row]

        cell.textLabel?.text = contact.displayName
        cell.detailTextLabel?.text = contact.phoneNumber

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactId = viewModel.contacts[indexPath.row].identifier
        navigateToDetail(contactId: contactId)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let contactId = viewModel.contacts[indexPath.row].identifier
        viewModel.deleteContact(contactId: contactId)
    }
}


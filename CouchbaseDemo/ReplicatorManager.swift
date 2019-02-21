//
//  ReplicatorManager.swift
//  CouchbaseDemo
//
//  Created by Matteo Sist on 21/02/2019.
//  Copyright © 2019 MOLO17 SRL. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

class ReplicatorManager {

    init(remoteURL: URL) {
        // STEP 42
        do {
            database = try Database(name: DatabaseName)
        } catch {
            fatalError("Error opening database")
        }

        // STEP 43
        let targetEndpoint = URLEndpoint(url: remoteURL)

        let replConfig = ReplicatorConfiguration(database: database, target: targetEndpoint)
        replConfig.replicatorType = .pushAndPull
        replConfig.authenticator = BasicAuthenticator(username: Username, password: Password)

        replicator = Replicator(config: replConfig)
    }

    // MARK: - Public properties

    // STEP 44
    func startReplication() {
        listenerToken = replicator.addChangeListener { (change) in
            if let error = change.status.error as NSError? {
                print("Error code :: \(error.code)")
            }
        }

        replicator.start()
    }

    // STEP 45
    func stopReplication() {
        if let token = listenerToken {
            replicator.removeChangeListener(withToken: token)
        }
        replicator.stop()
    }

    // MARK: - Private properties

    // STEP 41
    private let database: Database

    private let replicator: Replicator

    private var listenerToken: ListenerToken?
}
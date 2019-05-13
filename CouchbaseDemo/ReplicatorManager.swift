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
        /// STEP 42
        /// Init database with database name.
//        do {
//            database = try Database(name: DatabaseName)
//        } catch {
//            fatalError("Error opening database")
//        }

        /// STEP 43
        /// Declare and init replicator with a remote url, a replicator type, continuous option enable or not and a basic authentication.
//        let targetEndpoint = URLEndpoint(url: remoteURL)
//
//        let replConfig = ReplicatorConfiguration(database: database, target: targetEndpoint)
//        replConfig.replicatorType = .pushAndPull
//        replConfig.continuous = true
//        replConfig.authenticator = BasicAuthenticator(username: Username, password: Password)
//
//        replicator = Replicator(config: replConfig)
    }

    // MARK: - Public properties

    /// STEP 44
    /// Start replication function. Register a listener to listen replication status and start the replication.
    func startReplication() {
//        listenerToken = replicator.addChangeListener { (change) in
//            if let error = change.status.error as NSError? {
//                print("Error code :: \(error.code)")
//            }
//        }
//
//        replicator.start()
    }

    /// STEP 45
    /// Stop replication function. Deregister the replication status listener and stop the replication.
    func stopReplication() {
//        if let token = listenerToken {
//            replicator.removeChangeListener(withToken: token)
//        }
//        replicator.stop()
    }

    // MARK: - Private properties

    /// STEP 41
    /// Declare database and replication variables.
//    private let database: Database
//    private let replicator: Replicator

    private var listenerToken: ListenerToken?
}

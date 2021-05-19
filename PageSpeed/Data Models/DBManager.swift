//
//  DBManager.swift
//  PageSpeed
//
//  Created by Alex on 3/14/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {

    // MARK: - Properties

    private var database: Realm
    static let sharedInstance = DBManager()

    // MARK: - Init

    private init?() {
        do {
            self.database = try Realm()
            print("Realm path: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        } catch {
            print("Realm init error: \(error)")
            return nil
        }
    }

    // MARK: - Methods

    static func migrateToNewSchema() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                    // Auto update
                    print("New Schema description: \(migration.newSchema.description)")
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }

    static func dropDatabase() -> Bool {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("management"),
            realmURL.appendingPathExtension("note")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                print("Drop Realm error: \(error)")
                return false
            }
        }
        return true
    }

    func getPageSpeedV5Items() -> Results<PageSpeedV5Item> {
        let results: Results<PageSpeedV5Item> = database.objects(PageSpeedV5Item.self)
            .sorted(byKeyPath: "analysisUTCTimestamp", ascending: false)
        return results
    }

    func addPageSpeedV5Item(object: PageSpeedV5Item) -> Bool {
        do {
            try database.write {
                database.add(object)
                print("New object added")
            }
            return true
        } catch {
            print("Realm write error: \(error)")
            return false
        }
    }

    func deleteAllFromDatabase() -> Bool {
        do {
            try database.write {
                database.deleteAll()
            }
            return true
        } catch {
            print("Realm write error: \(error)")
            return false
        }
    }

    func deletePageSpeedV5Item(object: PageSpeedV5Item) -> Bool {
        do {
            try database.write {
                database.delete(object)
                print("The object deleted")
            }
            return true
        } catch {
            print("Realm write error: \(error)")
            return false
        }
    }
}

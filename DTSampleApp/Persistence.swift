//
//  Persistence.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/11/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer = CoreDataManager.shared.container
}

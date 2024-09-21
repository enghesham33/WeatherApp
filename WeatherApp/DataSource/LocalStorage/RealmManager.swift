//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import Foundation
import RealmSwift

class RealmManager {
    public static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func getAllDataFor(_ T : Object.Type) -> [Object] {
        
        var objects = [Object]()
        for result in realm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func getAllDataFor(_ T : Object.Type, filterdBy query :String) -> [Object] {
        var objects = [Object]()
        
        for result in realm.objects(T).filter(query) {
            objects.append(result)
        }
        return objects
       
    }
    
    func deleteAllDataFor(_ T : Object.Type) {
        self.delete(self.getAllDataFor(T))
    }
    
    func replaceAllDataFor(_ T : Object.Type, with objects : [Object]) {
        deleteAllDataFor(T)
        add(objects)
    }
    
    func add(_ objects : [Object], completion : @escaping() -> ()) {
        try? realm.write{
            realm.add(objects)
            completion()
        }
    }
    
    func add(_ objects : [Object]) {
        try? realm.write{
            realm.add(objects)
        }
    }
    
    func update(_ block: @escaping ()->Void) {
        try? realm.write(block)
    }
    
    func delete(_ objects : [Object]) {
        try? realm.write{
            realm.delete(objects)
        }
    }
    
    func configureMigration() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
}

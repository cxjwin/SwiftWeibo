//
//  DatabaseManager.swift
//  Weibo_Swift
//
//  Created by cxjwin on 10/26/14.
//  Copyright (c) 2014 cxjwin. All rights reserved.
//

import UIKit

class DatabaseManager: NSObject {
    var databaseName: String = "weibo.db"
    var tableNames: [String] = ["login_account", "statuses_data"]
    
    var database: FMDatabase
    
    class var defaultManager: DatabaseManager {
        struct Singleton {
            private static var manager = DatabaseManager()
        }
        
        return Singleton.manager;
    }
    
    override init() {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)
        let documentsDir: String = documentPaths[0] as String
        let databasePath = documentsDir.stringByAppendingPathComponent(documentsDir)
        database = FMDatabase(path: databasePath)
        
        super.init()
    }
    
    func checkAndCreateTables() {
        for name in tableNames {
            let sql = "select * from sqlite_master where type='table' and name='\(name)';"
            let result = database.executeQuery(sql, withArgumentsInArray:nil)
            
            if (name == "login_account" && (result == nil || !result.next())) {
                createLoginAccountTable()
            }
            
            if (name == "statuses_data" && (result == nil || !result.next())) {
                createStatusesDataTable()
            }
        }
    }
    
    func createLoginAccountTable() {
        print("\(__FUNCTION__)")
    }
    
    func createStatusesDataTable() {
        print("\(__FUNCTION__)")
    }
}

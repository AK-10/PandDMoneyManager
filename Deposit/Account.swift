//
//  Account.swift
//  Deposit
//
//  Created by Atsushi KONISHI on 2017/06/25.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import Foundation
import RealmSwift


class Account: Object{
    dynamic var name = ""
    dynamic var balance: Int = 0
    dynamic var id = 0
//    dynamic var id = RealmService.sharedInstance.items.last?.id + 1
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(_name: String){
        self.init()
        name = _name
        balance = 0
        id = RealmService.sharedInstance.items.last?.id != nil ? (RealmService.sharedInstance.items.last?.id)! + 1: 1
    }
    
    func charge(money: Int){
        try! RealmService.sharedInstance.realm.write {
            balance += money
            RealmService.sharedInstance.realm.add(self)
        }
    }
    
    func purchase(money: Int){
        try! RealmService.sharedInstance.realm.write {
            balance -= money
            RealmService.sharedInstance.realm.add(self)
        }
    }

}

class RealmService{
    
    static let sharedInstance = RealmService()
    
    var realm: Realm! = nil
    var items = List<Account>()
//    var notificationToken: NotificationToken! = nil

    
    init(){
//        self.setupRealm(callback: nil)
    }
    
    func setupRealm( callback:  (() -> Void)?){
        // Log in existing user with username and password

        let credential = SyncCredentials.usernamePassword(username: Parameters.username, password: Parameters.password,register: false)
        
        SyncUser.logIn(with: credential, server: Parameters.serverURL!, onCompletion: { user, error in
            if let unwrappeduser = user{
            } else if let unwrappederror = error{
                fatalError(String(describing: error))
            }
            DispatchQueue.main.async {
                let configuration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user!, realmURL: Parameters.realmURL!))
                
                self.realm = try! Realm(configuration: configuration)
                
                func updateList(){
                    self.items = List(self.realm.objects(Account.self))
                    callback?()
                }
                updateList()

            }
        })
    }
    

    
    func removeItem(item: Account, index: Int){
        try! realm.write {
            self.realm.delete(item)
            self.items.remove(at: index)
        }
    }
    
    func addItem(item: Account){
        try! self.realm.write {
            self.realm.add(item)
            self.items.append(item)
        }
    }


}


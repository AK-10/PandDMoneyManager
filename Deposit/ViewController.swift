//
//  ViewController.swift
//  Deposit
//
//  Created by Atsushi KONISHI on 2017/06/25.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var NameTable: UITableView!
    var sendingAccount: Account?
    
    //readOnlyなのでdeleteができない
//    var accounts :[Account] {
//        return Account.getData().map{ $0 }
//    }
    
    //var accounts = List<Account>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NameTable.dataSource = self
        NameTable.delegate = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NameTable.reloadData()
        NameTable.rowHeight = 60
        RealmService.sharedInstance.setupRealm {
            self.NameTable.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmService.sharedInstance.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NameTable.dequeueReusableCell(withIdentifier: "MyCell") as! CustomCell
        let data = RealmService.sharedInstance.items[indexPath.row]
        if data.balance < 0 {
            cell.nameLabel.text = data.name + "  ← 貧しい"
        } else {
            cell.nameLabel.text = data.name
        }
        let money = data.balance.description
        cell.balanceLabel.text = "¥ " + money
        
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeButton = UITableViewRowAction(style: .normal, title: "Remove"){(action, ip) -> Void in
            let alert = UIAlertController(title: "Caution", message: "本当に削除しますか?", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {action in
                let data = RealmService.sharedInstance.items[indexPath.row]
                RealmService.sharedInstance.removeItem(item: data, index: indexPath.row)
                self.NameTable.reloadData()
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {action -> Void in
                self.NameTable.reloadData()
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
           
            self.present(alert, animated: true, completion: nil)
        }
        removeButton.backgroundColor = UIColor.red
        
        return [removeButton]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendingAccount = RealmService.sharedInstance.items[indexPath.row]
        if(sendingAccount != nil){
            performSegue(withIdentifier: "toInfoView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "toInfoView") {
            let nextView = (segue.destination as? InfomationViewController)
            nextView!.selectedAccount = self.sendingAccount
        }
        
    }
    
}




class CustomCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!

}

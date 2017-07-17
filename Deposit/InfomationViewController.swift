//
//  InfomationViewController.swift
//  Deposit
//
//  Created by Atsushi KONISHI on 2017/06/26.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit
import RealmSwift

class InfomationViewController: UIViewController {
    
    @IBOutlet weak var chargeButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!

    @IBOutlet weak var Round: UIView!
    
    var selectedAccount: Account?
    var sendingAccount: Account?
    
    let realm: Realm! = nil
    
    var buttonFlag: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedAccount?.name
        balanceLabel.text = selectedAccount?.balance.description
        
        let width = Round.bounds.width
        Round.layer.cornerRadius = width / 2.0
        Round.layer.borderColor = UIColor(red: 65/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor
        Round.layer.borderWidth = 7
        
        chargeButton.layer.cornerRadius = 35
        chargeButton.layer.borderColor = UIColor(red: 65/255, green: 195/255, blue: 160/255, alpha: 1.0).cgColor
        chargeButton.layer.borderWidth = 3
        
        purchaseButton.layer.cornerRadius = 35
        purchaseButton.layer.borderColor = UIColor(red: 195/255, green: 65/255, blue: 100/255, alpha: 1.0).cgColor
        purchaseButton.layer.borderWidth = 3
        
        buttonFlag = 0
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        balanceLabel.text = "¥" + (selectedAccount?.balance.description)!

        buttonFlag = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapCharge(_ sender: Any) {
        buttonFlag = 1
        sendingAccount = selectedAccount
        if(sendingAccount != nil){
            performSegue(withIdentifier: "toMoneyView", sender: nil)
        }
    }
    
    @IBAction func tapPurchase(_ sender: Any) {
        buttonFlag = 2
        sendingAccount = selectedAccount
        if(sendingAccount != nil){
            performSegue(withIdentifier: "toMoneyView", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "toMoneyView") {
            let MoneyView = segue.destination as! MoneyViewController
            MoneyView.selectedAccount = self.selectedAccount
            MoneyView.receivedFlag = self.buttonFlag
        }
    }
}

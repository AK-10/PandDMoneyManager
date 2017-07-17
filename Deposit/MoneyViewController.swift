//
//  MoneyViewController.swift
//  Deposit
//
//  Created by Atsushi KONISHI on 2017/06/26.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {


    @IBOutlet weak var numLabel: UILabel!
    var selectedAccount: Account?
    var receivedFlag: Int = 0
    var num :Int = 0
    
    @IBOutlet var numButton: [UIButton]!
    @IBOutlet weak var enter: UIButton!
    
    override func viewWillAppear(_ animated: Bool){
        if(receivedFlag == 1) {
            enter.backgroundColor = UIColor(red: 19/255, green: 187/255, blue: 146/255, alpha: 1.0)
        }
        else if(receivedFlag == 2) {
            enter.backgroundColor = UIColor(red: 204/255, green: 51/255, blue: 102/255, alpha: 1.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = numButton.map{ $0.addTarget(self, action: #selector(MoneyViewController.buttonTapped(_:)), for: .touchUpInside) }

        numButton.forEach{ $0.layer.cornerRadius = 20 }
        
        enter.layer.cornerRadius = 20

        numLabel.text = "¥ " + num.description
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func buttonTapped(_ sender: UIButton){
        switch sender.tag {
        case 0 ..< 10:
            num = num * 10 + sender.tag
        case 10:
            num *= 100
        case 11:
            num = 0
        default:
            break
        }
        numLabel.text = "¥ " + num.description
    }
    
    @IBAction func tapEnter(_ sender: Any) {
        if(selectedAccount != nil){
            switch receivedFlag {
            case 1:
               selectedAccount?.charge(money: num)
            case 2:
                selectedAccount?.purchase(money: num)
            default:
                break
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


}






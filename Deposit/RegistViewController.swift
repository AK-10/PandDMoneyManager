//
//  RegistViewController.swift
//  Deposit
//
//  Created by Atsushi KONISHI on 2017/06/25.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {
    
    @IBOutlet weak var EnterButton: UIButton!
    @IBOutlet weak var NameField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EnterButton.layer.cornerRadius = 20
        self.NameField.layer.cornerRadius = 20
        for _ in 0 ... 100 {
            print("\n")
        }
        print(RealmService.sharedInstance.items.realm.debugDescription)
        //print(RealmService.sharedInstance.realm)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func tapEnter(_ sender: Any) {
        if (NameField.text == "") {
            let alert = UIAlertController(title: "Warning", message: "名前を入力してください。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        } else {
            let data = Account.init(_name: NameField.text!)
            RealmService.sharedInstance.addItem(item: data)
            self.navigationController?.popViewController(animated: true)
        }
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

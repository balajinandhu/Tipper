//
//  ViewController.swift
//  Tipper
//
//  Created by bnarayanaswami on 3/13/17.
//  Copyright © 2017 bnarayanaswami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let result = UserDefaults.standard.value(forKey: "default_tip_index") ?? 0
       
        print(result)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        let result = UserDefaults.standard.value(forKey: "default_tip_index") ?? 0
        tipControl.selectedSegmentIndex = result as! Int
        calculateTip(self)
        print(result)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipPercentages = [0.1, 0.15, 0.25]
       let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}


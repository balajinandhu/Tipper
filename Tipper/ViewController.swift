//
//  ViewController.swift
//  Tipper
//
//  Created by bnarayanaswami on 3/13/17.
//  Copyright © 2017 bnarayanaswami. All rights reserved.
//

import UIKit
import Foundation

func getSymbolForCurrencyCode(code: String) -> String? {
    let locale = NSLocale(localeIdentifier: code)
    return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
}


extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = getSymbolForCurrencyCode(code: Locale.current.currencyCode!)
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        let result = UserDefaults.standard.value(forKey: "default_tip_index") ?? 0
        tipControl.selectedSegmentIndex = result as! Int
        calculateTip(self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        if let amountString = billField.text?.currencyInputFormatting() {
            billField.text = amountString
        }
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        fmt.locale = Locale.current
        
       let tipPercentages = [0.1, 0.15, 0.25]
    
        let newString = billField.text?.replacingOccurrences(of: getSymbolForCurrencyCode(code: Locale.current.currencyCode!)!, with: "")
.replacingOccurrences(of: ",", with: "")

        let bill = Double(newString!) ?? 0.0
        print(bill)
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        tipLabel.text = getSymbolForCurrencyCode(code: Locale.current.currencyCode!)! + " " + fmt.string(for: tip)!
        totalLabel.text = getSymbolForCurrencyCode(code: Locale.current.currencyCode!)! + " " + fmt.string(for: total)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}


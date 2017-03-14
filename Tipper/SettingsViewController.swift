//
//  SettingsViewController.swift
//  Tipper
//
//  Created by bnarayanaswami on 3/13/17.
//  Copyright © 2017 bnarayanaswami. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var defaultTip: UILabel!
    @IBOutlet weak var tipPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.tipPicker.delegate = self
        self.tipPicker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["10", "15", "25"]
        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        let result = UserDefaults.standard.value(forKey: "default_tip_index") ?? 0
        tipPicker.selectRow(result as! Int, inComponent: 0, animated: true)
        defaultTip.text = String(format: "%.2f",Float(pickerData[result as! Int])!) + " %"
    }
    // Catpure the picker view selection
    func pickerView(_ pickerView : UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        defaultTip.text = String(format: "%.2f",Float(pickerData[row])!) + " %"
        UserDefaults.standard.setValue(row, forKey: "default_tip_index")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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

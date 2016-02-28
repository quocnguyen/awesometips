//
//  ViewController.swift
//  awesometips
//
//  Created by quocnguyen on 2/28/16.
//  Copyright © 2016 quocnguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipSliderLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    var tipPer = 0.1 // default tip percentage
    let step: Float = 0.01 // step for ui slider
    let db = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipSlider.value = Float(tipPer)
        
        tipAmount.text = "$.0.0"
        totalAmount.text = "$.0.0"
        
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tipSegment.selectedSegmentIndex = UISegmentedControlNoSegment
        
        tipPer = Double(db.floatForKey("tipPer"))
        if (tipPer == 0.0) {
            tipPer = 0.1
        }
        
        tipSlider.value = Float(tipPer)
        tipSliderLabel.text = String(format: "%.0f", tipPer * 100) + "%"
        
        calculate(getBillAmount(), tipPercentage: tipPer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onSliderMoved(sender: UISlider) {
        // unselect segment when user using slider
        tipSegment.selectedSegmentIndex = UISegmentedControlNoSegment
        
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        tipPer = Double(tipSlider.value)
        tipSliderLabel.text = String(format: "%.0f", tipPer * 100) + "%"
        
        calculate(getBillAmount(), tipPercentage: tipPer)
    }
    
    @IBAction func onSegmentChanged(sender: AnyObject) {
        let perList = [0.1, 0.15, 0.2]
        
        tipPer = perList[tipSegment.selectedSegmentIndex]
        
        tipSlider.value = Float(tipPer)
        tipSliderLabel.text = String(format: "%.0f", tipPer * 100) + "%"
        
        
        calculate(getBillAmount(), tipPercentage: tipPer)
    }
    


    @IBAction func onEditing(sender: AnyObject) {
        calculate(getBillAmount(), tipPercentage: tipPer)
    }
    
    func calculate(billAmount: Double, tipPercentage: Double) {
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipAmount.text = String(format: "$%.2f", tip)
        totalAmount.text = String(format: "$%.2f", total)
    }
    
    func getBillAmount() -> Double {
        return NSString(string: billField.text!).doubleValue
    }


}


//
//  SettingsViewController.swift
//  awesometips
//
//  Created by quocnguyen on 2/28/16.
//  Copyright © 2016 quocnguyen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let step: Float = 0.01
    let db = NSUserDefaults.standardUserDefaults()


    @IBOutlet weak var tipSliderLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        var tipPer = Double(db.floatForKey("tipPer"))
        if (tipPer == 0.0) {
            tipPer = 0.1
        }
        
        tipSliderLabel.text = String(format: "%.0f", tipPer * 100) + "%"
        tipSlider.value = Float(tipPer)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSliderChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        tipSliderLabel.text = String(format: "%.0f", sender.value * 100) + "%"
        db.setFloat(sender.value, forKey: "tipPer")
        db.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

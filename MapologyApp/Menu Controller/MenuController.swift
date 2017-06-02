//
//  MenuController.swift
//  MapologyApp
//
//  Created by 34in on 08/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet var distance_lbl: UILabel!
    @IBOutlet var slider_distance: UISlider!
    
    
    @IBAction func sliderAction(_ sender: UISlider)
    {
        let value:Int = Int(sender.value)
        distance_lbl.text = "Distance " + String(value) + "KM"
    }
    
    
    @IBAction func loginSwitch(_ sender: Any) {
    }
    
    @IBOutlet var loginbtn: UIButton!
    
    @IBOutlet var soundbtn: UIButton!
    
    @IBAction func soundSwitch(_ sender: Any) {
    }
    
    @IBOutlet var notificationBtn: UIButton!
    
    
    @IBOutlet var NotificationSwitch: UISwitch!
    
    @IBAction func NotificationSwitch(_ sender: Any) {
    }
    
    @IBOutlet var GPSBtn: UIButton!
    
    @IBAction func GPSSwitch(_ sender: Any) {
    }
    
    @IBOutlet var DistanceBtn: UIButton!
    
    @IBAction func DistanceSwitch(_ sender: Any) {
    }
    
    @IBOutlet var VisitBtn: UIButton!
    
    @IBOutlet var TermsBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginbtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
        soundbtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
           notificationBtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
           GPSBtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
           DistanceBtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
           VisitBtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
         TermsBtn.addBottomBorderWithColor(color: UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0), width: 1)
        
        

        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        
        menuSelected = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        menuSelected = false
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    
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

}

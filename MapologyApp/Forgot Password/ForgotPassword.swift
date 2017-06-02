//
//  ForgotPassword.swift
//  MapologyApp
//
//  Created by 34in on 14/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {
    @IBOutlet var lbl_txt: UILabel!

    @IBOutlet var Email: UITextField!
    
    @IBAction func Forgot_action(_ sender: Any) {
        
        if Email.text?.isEmpty == true
        {
            alertshow(message: "Please Enter Email Address", title: "Email is Empty", view: self)
        }
            
        else if isValidEmail(testStr: Email.text!) == false
        {
            alertshow(message: "Please Enter Valid Email Address", title: "Email is Invalid", view: self)
        }
            
        else
        {
            MbprogressHudShow(self.view)
            
            let params = ForgotData(Email.text!)
            
            APIInstance.postDatatoServer(ForgotAPI, parameter: params, success: { (response) in
                
                    let data = try! response.rawData()
                    
                    let json:NSDictionary = serialization(data: data)
                    
                    if json.value(forKey: "status")as! NSNumber == 1
                    {
                        self.navigationController!.popViewController(animated: false)
                        
                        alertshow(message: "Password detail sent on your email.", title: "Success!", view: self)
                    }
                
                   dissmissHUD(self.view)
              
                
            //    print(response)
                
            }) { (error) in
                
                print(error.localizedDescription)
                
                dissmissHUD(self.view)
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Email.setLeftPaddingPoints()
       // self.navigationItem.title = "FORGOT PASSWORD?"

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

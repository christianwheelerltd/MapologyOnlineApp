//
//  Register.swift
//  MapologyApp
//
//  Created by 34in on 14/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit

class Register: UIViewController {

    @IBOutlet var name: UITextField!
    
    @IBOutlet var surname: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    @IBAction func Signup(_ sender: Any) {
        
        print(isValidEmail(testStr: email.text!))
        
        if email.text?.isEmpty == true
        {
            alertshow(message: "Please Enter Email Address", title: "Email is Empty", view: self)
        }
            
        else if isValidEmail(testStr: email.text!) == false
        {
          alertshow(message: "Please Enter Valid Email Address", title: "Email is Invalid", view: self)
        }
            
        else
        {
        MbprogressHudShow(self.view)
        
        let params = RegisterData(name.text!, surname: surname.text!, email: email.text!, password: password.text!)
        
        print("Parameter is \(params)")
        
        APIInstance.postDatatoServer(registerAPI, parameter: params, success: { (response) in

            let data = try! response.rawData()
            
            let json:NSDictionary = serialization(data: data)
            
            if json.value(forKey: "status")as! NSNumber == 1
            {
                self.navigationController!.popViewController(animated: false)
                alertshow(message: "Register Successfully!", title: "Success!", view: self)
            }
            else
            {
        alertshow(message: "Something went wrong!", title: "Error!", view: self)
            }
               dissmissHUD(self.view)


        }) { (error) in
            
            print(error.localizedDescription)
            
            dissmissHUD(self.view)

        }
    }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    name.setLeftPaddingPoints()
    surname.setLeftPaddingPoints()
    email.setLeftPaddingPoints()
    password.setLeftPaddingPoints()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func REgister_btns(_ sender: Any) {
        
        
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

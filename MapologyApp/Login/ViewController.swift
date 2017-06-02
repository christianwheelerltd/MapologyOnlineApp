//
//  ViewController.swift
//  MapologyApp
//
//  Created by 34in on 14/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate,CLLocationManagerDelegate {

    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Password: UITextField!

    
    let managers = CLLocationManager()
    
    func CurrentLocation()
    {
        
        self.managers.requestAlwaysAuthorization()
        self.managers.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.managers.delegate = self
            
            self.managers.desiredAccuracy = kCLLocationAccuracyBest
            self.managers.startUpdatingLocation()
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error.localizedDescription")
        print(error)
    }
    
func locationManager(manager: CLLocationManager!, didUpdateLocations locations:  [AnyObject]!)
{
        locValue = manager.location!.coordinate
        print("locations = \(manager.location!.coordinate.latitude) \(manager.location!.coordinate.longitude)")
        
        manager.stopUpdatingLocation()
    }
    
    
    @IBAction func Facebook_login(_ sender: Any)
    {
        facebookLogin()
    }
    
    @IBAction func Twitter_login(_ sender: Any)
    {
        TwiterLogin()
    }
    
    @IBAction func Google_login(_ sender: Any)
    {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    private func signInWillDispatch(signIn: GIDSignIn!, error: Error!) {
   
    }
    // Present a view that prompts the user to sign in with Google
    
    private func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    // Dismiss the "Sign in with Google" view
    
    private func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
              MbprogressHudShow(self.view)
        
        if (error == nil) {
            
//            print("user data is \(user.profile.email)")
//            print("user data is \(user.userID)")
//            print("user data is \(user.profile.givenName)")
//            print("user data is \(user.profile.familyName)")
//            
            
            var param = NSDictionary()
            
            if let socialEmail = user.profile.email
            {
        param = SocialData(socialEmail, fname: user.profile.givenName, lname: user.profile.familyName, socialType: "google", socialID: user.userID)
            }
            else
            {
        param = SocialData("", fname: user.profile.givenName, lname: user.profile.familyName, socialType: "google", socialID: user.userID)
                
            }
    
            print(param)
            
            APIInstance.postDatatoServer(registerAPI, parameter: param, success: { (response) in
                
                let data = try! response.rawData()
                
                let json:NSDictionary = serialization(data: data)
                
                if json.value(forKey: "status")as! NSNumber == 1
                {
                    print("success")
                    
                    self.Home_redirect()
                }
                
                dissmissHUD(self.view)
                
            }) { (error) in
                
                print(error.localizedDescription)
                
                dissmissHUD(self.view)
                
            }

        } else {
            print("\(error.localizedDescription)")
            dissmissHUD(self.view)
        }
    }
    
    
    @IBAction func Login_action(_ sender: Any) {
        
      //  Home_redirect()
        
      //  Email.text = "harsh1@test.com"
     //   Password.text = "123456"
        
        if Email.text?.isEmpty == true
        {
            alertshow(message: "Please Enter Email Address", title: "Email is Empty", view: self)
        }
            
        else if isValidEmail(testStr: Email.text!) == false
        {
            alertshow(message: "Please Enter Valid Email Address", title: "Email is Invalid", view: self)
        }
        
        else if Password.text?.isEmpty == true
        {
            alertshow(message: "Please Enter Password", title: "Password is Empty", view: self)
        }
        else
        {
            
        MbprogressHudShow(self.view)
        
        let params = LoginData(Email.text!, password: Password.text!)
            
            print(params)
        
        APIInstance.postDatatoServer(loginAPI, parameter: params, success: { (response) in
            
       // print(response)
            
            let data = try! response.rawData()
            
            let json:NSDictionary = serialization(data: data)
            
           // print(json)
            
            if json.value(forKey: "status")as! NSNumber == 1
            {
              SaveToken(json: json)
              self.Home_redirect()
            }
                
            else
            {
            alertshow(message: json.value(forKey: "message")as! String, title: "Warning!", view: self)
            }
            
              dissmissHUD(self.view)
        }) { (error) in
            
            print(error.localizedDescription)
            
            dissmissHUD(self.view)
            
        }
      }
    }
    
    
    @IBAction func Forgot(_ sender: Any)
    {
        
    let forgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPassword
        
  self.navigationController?.pushViewController(forgotVC, animated: true)
    
    }
    
    @IBAction func Register_action(_ sender: Any) {
        
        let RegisterVC = self.storyboard?.instantiateViewController(withIdentifier: "Register") as! Register
        
        self.navigationController?.pushViewController(RegisterVC, animated: true)
        
    }
    
    
    func NavigationShow ()
    {

    self.navigationController?.navigationBar.barTintColor = GreenColor
        
    let button1 = UIBarButtonItem(image: UIImage(named:"side.png"), style: .plain, target: self, action:#selector(ViewController.Left))
    
    self.navigationItem.leftBarButtonItem  = button1
    self.navigationController?.navigationBar.addSubview(NavigationTitle(size: self.view))
    }
    
    func Left ()
    {
        if menuSelected
        {
        self.slidingViewController().resetTopView(animated: true)
        }
        else
        {
        self.slidingViewController().anchorTopViewToRight(animated: true)
        }
        
    }

    
   // MARK: Twitter Login
    
        func TwiterLogin() {
    
            let logInButton = TWTRLogInButton() { session, error in
    
                if (session != nil) {
                    print("signed in as \(session?.userName)")
                } else {
                    print("error: \(error?.localizedDescription)")
                }
            }
            logInButton.loginMethods = [.webBased]
    
            // If using the log in methods on the Twitter instance
            Twitter.sharedInstance().logIn(withMethods: [.webBased]) { session, error in
    
                if ((session) != nil){
    
                    let client = TWTRAPIClient.withCurrentUser()
                    let request = client.urlRequest(withMethod: "GET",
                                                    url: "https://api.twitter.com/1.1/account/verify_credentials.json",
                                                    parameters: ["include_email": "true", "skip_status": "true"],
                                                    error: nil)
    
                    client.sendTwitterRequest(request) { response, data, connectionError in
    
    
                        let json:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
    
                        print(json)
    
//    
                        self.socialAvtarImage = json.object(forKey: "profile_image_url") as! String
                        self.socialFirstName = json.object(forKey: "name") as! String
                        self.socialLastName = json.object(forKey: "screen_name") as! String
                        self.socialEmail = json.object(forKey: "email") as! String
    
                        let twitID = json.object(forKey: "id") as! NSNumber
    
                        self.socialID = String.localizedStringWithFormat("%@", twitID)
                        
                        var param = NSDictionary()
                        
                        var fname:String = ""
                        var lname:String = ""
                        
                        fname = json.object(forKey: "name") as! String
       
        var fullNameArr = fname.characters.split{$0 == " "}.map(String.init)
                        
             fname = fullNameArr[0]
                        
            if fullNameArr.count > 1
            {
                lname = fullNameArr[1]
            }
                
                if let socialEmail = json.object(forKey: "email") as? String
             {
                param = SocialData(socialEmail, fname: fname, lname: lname, socialType: "twitter", socialID: self.socialID)
                }
            else
                {
                    param = SocialData("", fname: fname, lname: lname, socialType: "twitter", socialID: self.socialID)
                            
                }
                        
                        APIInstance.postDatatoServer(registerAPI, parameter: param, success: { (response) in
                            
                            let data = try! response.rawData()
                            
                            let json:NSDictionary = serialization(data: data)
                            
                            if json.value(forKey: "status")as! NSNumber == 1
                            {
                                print("success")
                                
                                self.Home_redirect()
                            }
                            
                            
                            
                            dissmissHUD(self.view)
                            
                        }) { (error) in
                            
                            print(error.localizedDescription)
                            
                            dissmissHUD(self.view)
                            
                        }
                        

                        
                        
    
                       // self.sendTwitterData()
                    }
    
    
    
    
                }else{
                    
                    print(error?.localizedDescription ?? "error print")
                }
                
            }
            
            
        }
    
    
    // MARK: Home Method
    
    func Home_redirect()
    {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeController
        
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    
    //MARK:TapButonFacebookLogin
    
    func facebookLogin()  {
        
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.native
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email", "user_friends","user_birthday","user_about_me","user_location"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    
                    
                   // if(fbloginresult.grantedPermissions.contains("email"))
                  //  {
                        
                        MbprogressHudShow(self.view)
                        
                        self.getUserDataFromFacebook()
                  //  }
                }
            }
            
        }
        
        
    }
    
    
    //Mark:FbLoginData
    
     var dict : [String : AnyObject]!
     var fbUserDataDict = NSDictionary()
    var socialID = String()
    var socialFirstName = String()
    var socialLastName = String()
    var socialEmail = String()
    var socialAvtarImage = String()
    
    func getUserDataFromFacebook() {
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, gender, birthday, name, first_name, last_name, picture.type(large), email, link, location, friends"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    self.fbUserDataDict = result as! NSDictionary
                    
                    
                  //  print(self.fbUserDataDict)
                    
                  //  let profile_image: NSDictionary? = ((self.fbUserDataDict.object(forKey: "picture") as Any) as! NSDictionary).object(forKey: "data") as? NSDictionary
                    
                  //  self.socialAvtarImage = profile_image?.object(forKey: "url") as! String
                    
                    var param = NSDictionary()
                    
               if let socialEmail = self.fbUserDataDict.object(forKey: "email") as? String
               {
                   param = SocialData(socialEmail, fname: self.fbUserDataDict.object(forKey: "first_name") as! String, lname: self.fbUserDataDict.object(forKey: "last_name") as! String, socialType: "facebook", socialID: self.fbUserDataDict.object(forKey: "id") as! String)
                    }
                else
               {
                 param = SocialData("", fname: self.fbUserDataDict.object(forKey: "first_name") as! String, lname: self.fbUserDataDict.object(forKey: "last_name") as! String, socialType: "Facebook", socialID: self.fbUserDataDict.object(forKey: "id") as! String)
                
                }
                    
                   // print("Facebook data \(param)")
                    
                    APIInstance.postDatatoServer(registerAPI, parameter: param, success: { (response) in
                        
                        let data = try! response.rawData()
                        
                        let json:NSDictionary = serialization(data: data)
                 
                        if json.value(forKey: "status")as! NSNumber == 1
                        {
                        print("success")
                            
                            self.Home_redirect()
                        }
                        
                       
                        
                        dissmissHUD(self.view)
                        
                    }) { (error) in
                        
                        print(error.localizedDescription)
                        
                        dissmissHUD(self.view)
                        
                    }
                
                    
//                    self.socialFirstName = self.fbUserDataDict.object(forKey: "first_name") as! String
//                    self.socialLastName = self.fbUserDataDict.object(forKey: "last_name") as! String
//                    self.socialEmail = self.fbUserDataDict.object(forKey: "email") as! String
//                    self.socialID = self.fbUserDataDict.object(forKey: "id") as! String
//                    
//                    
//                    self.loginwithFacebook()
                    
                }
            })
        }
        
    }
    
    
    //MARK:- sendFbDatatoServer
    
    func loginwithFacebook()  {
        
        
//        APIInstance.fbLogin(baseUrl+registerAPI, email: self.socialEmail, password: "123456", fbID: self.socialID, fbavatr: self.socialAvtarImage, firstName: self.socialFirstName, lastname: self.socialLastName, registerWith: issocialType, mobile: textField.text!, deviceType: "IOS", deviceToken: "", registertype: "social",lati: latitude , longi: logitude , success: { (response) in
//            
//            
//            let data = try! response.rawData()
//            
//            self.json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//            
//            print(self.json)
//            
//            dissmissHUD(self.view)
//            
//            let checkMobileExist = self.json .value(forKey: "mobile") as! NSString
//            
//            
//            if checkMobileExist .isEqual(to: "") {
//                
//                self.alertTextfieldShow()
//                
//                
//            }else{
//                
//                UserDefaults.standard .set(self.json, forKey: "userData")
//                
//                
//                let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "home")
//                self.navigationController?.pushViewController(homeVc!, animated: true)
//            }
//            
//            
//            
//            
//        }) { (error) in
//            
//            dissmissHUD(self.view)
//            
//            print(error.localizedDescription)
//        }
//        
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
                CurrentLocation()
        
        UpdateLocationServer()
        Email.setLeftPaddingPoints()
        Password.setLeftPaddingPoints()
    
        self.navigationItem.title = "Login"
        
          GIDSignIn.sharedInstance().uiDelegate = self
          GIDSignIn.sharedInstance().delegate = self
        
//         GIDSignIn.sharedInstance().delegate = self
        
       // self.navigationController?.navigationBar.isHidden = true
      //  NavigationShow ()
      //  self.view.addGestureRecognizer(self.slidingViewController().panGesture)

    }

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

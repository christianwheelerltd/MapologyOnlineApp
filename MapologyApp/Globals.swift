//
//  Globals.swift
//  MapologyApp
//
//  Created by 34in on 08/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit

var menuSelected  = false
var deviceTokenString:String = ""

var selectedOffer:String = ""


var baseUrl:String = "http://skillboot.com/projects/dating/api/"

var registerAPI:String = "register"
var loginAPI:String = "login"
var ForgotAPI:String = "forgotPassword"
var ArticlesAPI:String = "articles?page="
var ArticlesDetailsAPI:String = "singleArticle"
var SaveFollowArticleAPI:String = "saveFollowArt"


var UpdateLocationAPI:String = "locationUpdate"

var ProductImagePath:String = "http://skillboot.com/projects/dating/public/images/ret_ail_ers/articles/"

var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D()


//MARK: Color Scheme

let GreenColor = UIColor(red: 85.0/255.0, green: 202.0/255.0, blue: 34.0/255.0, alpha: 1.0)

let PinkColor = UIColor(red: 178.0/255.0, green: 9.0/255.0, blue: 53.0/255.0, alpha: 1.0)

let BlueColor = UIColor(red: 60.0/255.0, green: 138.0/255.0, blue: 179.0/255.0, alpha: 1.0)

let YellowColor = UIColor(red: 239.0/255.0, green: 183.0/255.0, blue: 41.0/255.0, alpha: 1.0)

let PinkColor2 = UIColor(red: 230.0/255.0, green: 80.0/255.0, blue: 119.0/255.0, alpha: 1.0)


func devicetokenStatus ()-> String
{
    if deviceTokenString != ""
    {
        return deviceTokenString
    }
    
    return "off"
}

// MARK: Register Method

func RegisterData(_ name:String, surname:String,email:String,password:String)->NSDictionary
{
    locValue.latitude = 30.12312
    locValue.longitude = 74.12312
    
    return ["data": ["name":name,"surname":surname,"email":email,"password":password,"deviceToken":devicetokenStatus(),"lati":String(locValue.latitude),"longi":String(locValue.longitude)]]
}

// MARK: Login Method

func LoginData(_ email:String,password:String)->NSDictionary
{
    return ["data": ["email":email,"password":password,"lati":String(locValue.latitude),"longi":String(locValue.longitude),"deviceToken":devicetokenStatus()]]
}

// MARK: Forgot Method

func ForgotData(_ email:String)->NSDictionary
{
    return ["data": ["email":email]]
}

// MARK: OfferData 

func OfferData(type:String)-> NSDictionary
{
  
    let userid = userID_Token(type: "UserID")
    let token =  userID_Token(type: "Token")
    
    var catArray:NSArray = NSArray()
    var milesArray:NSArray = NSArray()
    
    if type == "all"
    {
   // catArray = ["coffee-shop","pub","fast-food","restaurant"]
    }
    else
    {
    catArray = [type]
    }
    
//    milesArray = [100,locValue.latitude,locValue.longitude]

      milesArray = [3000,30.7464418,76.7783748]
    
    return ["data": ["userId":userid,"token":token,"category":catArray,"miles":milesArray]]
}

// MARK: Article Detail

func ArticlesDetails(art_id:Int) -> NSDictionary
{
    let userid = userID_Token(type: "UserID")
    let token =  userID_Token(type: "Token")
    
    return ["data": ["userId":userid,"token":token,"id":art_id]]

}

// MARK: Follow Article

func FollowArticle(art_id:Int) -> NSDictionary
{
    let userid = userID_Token(type: "UserID")
    let token =  userID_Token(type: "Token")
    
    return ["data": ["userId":userid,"token":token,"articleId":art_id]]
    
}


// MARK: Forgot Method

func SocialData(_ email:String,fname:String,lname:String,socialType:String,socialID:String)->NSDictionary
{
    if email == ""
    {
    return ["data": ["name":fname,"surname":lname,"isSocial":"1","socialType":socialType,"socialId":socialID,"deviceToken":devicetokenStatus(),"lati":String(locValue.latitude),"longi":String(locValue.longitude)]]
    }
    else
    {
    return ["data": ["name":fname,"surname":lname,"email":email,"isSocial":"1","socialType":socialType,"socialId":socialID,"deviceToken":devicetokenStatus(),"lati":String(locValue.latitude),"longi":String(locValue.longitude)]]
}
}

//MARK: Get Default id

func userID_Token(type:String)->String
{
    if let data = UserDefaults.standard.object(forKey: type) as? String
    {
    return data
    }
    return ""
}


func SaveToken(json:NSDictionary)
{
    let token = json.value(forKey: "token") as! String
    let userid = String(describing: json.value(forKey: "userId") as! NSNumber)
    
    UserDefaults.standard.set(token, forKey: "Token")
    UserDefaults.standard.set(userid, forKey: "UserID")
    

    UpdateLocationServer()
}

// MARK: Update Location

func UpdateLocationServer()
{
    let userid = userID_Token(type: "UserID")
    let token =  userID_Token(type: "Token")
    
    if userid != "" && token != ""
    {
let param = ["data": ["userId":userid,"token":token,"lati":String(locValue.latitude),"longi":String(locValue.longitude)]]
        
        APIInstance.postDatatoServer(UpdateLocationAPI, parameter: param as NSDictionary, success: { (response) in
        }) { (error) in
            
            print(error.localizedDescription)
        }
    }
}

// MARK: Alert Method

func alertshow(message:String,title:String,view:UIViewController)  {
    
    let alertVc = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alertVc .addAction(UIAlertAction (title: "OK", style: UIAlertActionStyle.default))
    
    view.present(alertVc, animated: true, completion: nil)
}


// MARK: Serialization Method

func serialization(data:Data) -> NSDictionary
{
    return try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
    
    
}

//MARK: Current Date 

func CurrentDate()-> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let dateObj = dateFormatter.string(from: Date())
    return dateObj
}


// MARK: Prgress Bar Method

func MbprogressHudShow(_ view:UIView)  {
    
    let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
    loadingNotification?.mode = MBProgressHUDMode.indeterminate
    loadingNotification?.color = UIColor .lightGray
    //loadingNotification?.labelText = "Loading..."
    
}

func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


func dissmissHUD(_ view:UIView)  {
    
    MBProgressHUD.hideAllHUDs(for: view, animated: true)
}

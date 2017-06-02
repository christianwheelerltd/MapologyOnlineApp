//
//  AppDelegate.swift
//  MapologyApp
//
//  Created by 34in on 08/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import GooglePlaces

import FBSDKLoginKit
//import Fabric
import UserNotifications
import UserNotificationsUI
import NotificationCenter
import GoogleMaps



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    var window: UIWindow?

    
    
    
    func registerForPushNotifications(application: UIApplication) {
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
         deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
    }    

    
    func SocialLoginSetup()
    {
        Twitter.sharedInstance().start(withConsumerKey: "zDak1TIBdaPL0zwYcFhAyKCBs", consumerSecret: "AEG9rDtha5VKJh8Cb5L5eWUJEloolhn23Iuv389v4WRQjY8sV8")
              Fabric.with([Twitter.self])
        
    }
    
    func googleSetup()
    {
    
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
//        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if FBSDKApplicationDelegate.sharedInstance().application(app,open: url as URL!,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) {
            
            return true
            
        }
            
        else if Twitter.sharedInstance().application(app, open: url, options:options){
            
            return true
            
        }
        else
        {
            return GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                        annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
   
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject,
                                            UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation!]
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if (error == nil) {
            
             print("user data is \(user.profile.email)")
             print("user data is \(user.userID)")
             print("user data is \(user.profile.givenName)")
             print("user data is \(user.profile.familyName)")
            
            
            
         
            
            // Perform any operations on signed in user here.
//            let userId = user.userID                  // For client-side use only!
//            let idToken = user.authentication.idToken // Safe to send to the server
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }

    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
    GMSPlacesClient.provideAPIKey("AIzaSyBDoL4Mixp1sTcvw20F7IOXuz3q8hfk2kk")
        
    GMSServices.provideAPIKey("AIzaSyBIicnTWKxYBbipDqxZzlANuuH0FBAk3DA")
        
        
       // deviceTokenString = "ABCDEDED23232323"
        

        
        SocialLoginSetup()
        googleSetup()
        registerForPushNotifications(application: application)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 178.0/255.0, green: 9.0/255.0, blue: 53.0/255.0, alpha: 1.0)

           //   UINavigationBar.appearance().barTintColor = UIColor.black
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        
//        if FBSession.active().state == FBSessionStateCreatedTokenLoaded
//        {
//        self.openActiveSessionWithPermissions(nil, allowLoginUI: false)
//        }
//        
//        FBAppCall.handleDidBecomeActive()

    }
    

   
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


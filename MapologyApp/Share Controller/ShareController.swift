//
//  ShareController.swift
//  MapologyApp
//
//  Created by 34in on 28/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit
import FBSDKMessengerShareKit
import Messages
import MessageUI

class ShareController: UIViewController,FBSDKSharingDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate {

    
    @IBOutlet var fb: UIButton!
    
    @IBOutlet var messenger: UIButton!
    
    @IBOutlet var whats_app_btn: UIButton!
    
    @IBOutlet var twitter: UIButton!
    
    @IBOutlet var email_btn: UIButton!
    
    @IBOutlet var mobile_btn: UIButton!
    
    
    
    @IBAction func Facebook(_ sender: Any) {
        
        facebookShare()
    }
    
    @IBAction func Messenger(_ sender: Any) {
        facebookMessenger()
    }
    
    @IBAction func whats_App(_ sender: Any) {
        whatsapp()
    }
    
    @IBAction func twitter(_ sender: Any) {
        
        TwitterShare()
    }
    
    @IBAction func email_action(_ sender: Any) {
        
        MailComposer()
    }

    @IBAction func SMS_action(_ sender: Any)
    {
       SMS_Share()
    }

    public func sharerDidCancel(_ sharer: FBSDKSharing!)
    {
        
    }

    public func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!)
    {
        
    }
    
    public func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!)
    {
        
    }
    
    func facebookMessenger ()
    {
    if UIApplication.shared.canOpenURL(NSURL(string: "fb-messenger-api://")! as URL) {
    let content = FBSDKShareLinkContent()
    content.contentURL = NSURL(string: "http://www.google.com") as URL!
    content.contentTitle = "your awesome title"
            
    FBSDKMessageDialog.show(with: content, delegate: self)
    }
    else
    {
      NSLog("Messenger app is not available")
    }
    }
    
    func facebookShare()
    {
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        {
            vc.add(URL(string: "http://www.google.com"))
            present(vc, animated: true)
    }
     }
    
    func TwitterShare ()
    {
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        {
            vc.add(URL(string: "http://www.google.com"))
            //   vc.add(UIImage(named: "myImage.jpg")!)
            //    vc.add(URL(string: "https://www.hackingwithswift.com"))
            
            present(vc, animated: true)
        }
    }
    
    func whatsapp ()
    {
        let urlString = "Sending WhatsApp message through app in Swift"

        let urlwithPercentEscapes = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        let url  = NSURL(string: "whatsapp://send?text=\(urlwithPercentEscapes!)")
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        } else {
         alertshow(message: "Your device is not able to send WhatsApp message", title: "Cannot Send Message", view: self)
        }
        
    }

    func MailComposer()
    {
    let emailTitle = "Feedback"
    let messageBody = "Feature request or bug report?"
    let toRecipents = ["friend@stackoverflow.com"]
    let mc: MFMailComposeViewController = MFMailComposeViewController()
    mc.mailComposeDelegate = self
    mc.setSubject(emailTitle)
    mc.setMessageBody(messageBody, isHTML: false)
    mc.setToRecipients(toRecipents)
        
    self.present(mc, animated: true, completion: nil)
    }

    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func SMS_Share ()
    {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["2345665456456"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
   
        self.dismiss(animated: true, completion: nil)
    }
    

    func NavigationShow ()
    {
        self.navigationController?.navigationBar.barTintColor = GreenColor
        
        let button1 = UIBarButtonItem(image: UIImage(named:"Back.png"), style: .plain, target: self, action:#selector(ShareController.back))
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationController?.navigationBar.addSubview(NavigationTitle(size: self.view))
    }
    
    
    func back()
    {
        _ =  self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NavigationShow ()

        
        fb.SetBordor()
        messenger.SetBordor()
        whats_app_btn.SetBordor()
        email_btn.SetBordor()
        mobile_btn.SetBordor()
        twitter.SetBordor()
        
        // Do any additional setup after loading the view.
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

//
//  DetailController.swift
//  MapologyApp
//
//  Created by 34in on 27/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import CoreImage
import GoogleMaps
import Kingfisher

class DetailController: UIViewController {
    
    @IBOutlet var upperView: UIView!
    
    @IBOutlet var DetailScroll: UIScrollView!
    
    @IBOutlet var articleImg: UIImageView!
    var latitute:Double =  Double()
    var Longitute:Double = Double()
    var title_article:String?
    
    @IBAction func RouteDirection(_ sender: Any) {
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL))
        {
            UIApplication.shared.openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(latitute),\(Longitute)&directionsmode=driving")! as URL)
        }
        else
        {
            NSLog("Can't use comgooglemaps://");
        }
    }
 
    
    var ArticleID:Int = 0
    var Distance:String = ""
    
    @IBOutlet var title_lbl: UILabel!
    
    @IBOutlet var Share: UIButton!
    
    @IBOutlet var detail_lbl: UILabel!
    
    @IBOutlet var title1_lbl: UIButton!
    
    @IBOutlet var title2_lbl: UIButton!
    
    @IBOutlet var bottomView: UIView!
    
    
    
    @IBOutlet var mapview: GMSMapView!
    
    @IBOutlet var Map_View: UIView!

    @IBOutlet var Qr_img: UIImageView!
    @IBOutlet var QR_view: UIView!

    @IBAction func Share(_ sender: Any) {
        
    let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "ShareController") as! ShareController
        
    self.navigationController?.pushViewController(shareVC, animated: true)

    }
    
    
    
    func QRGenerate(_ str:String)
   {
        let data = str.data(using: String.Encoding.isoLatin1)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator")
        {
         filter.setValue(data, forKey: "inputMessage")
         let transform = CGAffineTransform(scaleX: 8, y: 8)
            
         if let output = filter.outputImage?.applying(transform)
         {
            Qr_img.image = UIImage(ciImage:output)
         }
       }
    }
    
    
    func back()
    {
     _ =  self.navigationController?.popViewController(animated: true)
    }
    
    func NavigationShow ()
    {
    self.navigationController?.navigationBar.barTintColor = GreenColor

    let button1 = UIBarButtonItem(image: UIImage(named:"Back.png"), style: .plain, target: self, action:#selector(DetailController.back))
        self.navigationItem.leftBarButtonItem  = button1
        
    self.navigationController?.navigationBar.addSubview(NavigationTitle(size: self.view))
    }
    
    
    func fetchDetails()
    {
        MbprogressHudShow(self.view)
        
        let params = ArticlesDetails(art_id: ArticleID)
        
        APIInstance.postDatatoServer(ArticlesDetailsAPI, parameter: params, success: { (response) in
            
            let data = try! response.rawData()
            
            let json:NSDictionary = serialization(data: data)
            
           //   print(json)
            
          //  let detailArray:NSMutableArray = (json.value(forKey: "data")as! NSArray).mutableCopy() as! NSMutableArray
            
            if json.value(forKey: "status")as! NSNumber == 1
            {
                
     if let QRCode = ((json.object(forKey: "data") as AnyObject).value(forKey: "cc") as? String)
     {
        self.QRGenerate(QRCode)
     }
            let url = URL(string: ProductImagePath + ((json.object(forKey: "data") as AnyObject).value(forKey: "coverImage") as! String))!
                
            self.articleImg.kf .setImage(with: url, placeholder:UIImage (named: "placehoderUser.png"))

            self.title_article = ((json.object(forKey: "data") as AnyObject).value(forKey: "title") as! String)
                
            self.title_lbl.text = "  " + self.title_article!
                
            self.detail_lbl.text = "  " + ((json.object(forKey: "data") as AnyObject).value(forKey: "content") as! String)
                
            self.title1_lbl.setTitle("  " + ((json.object(forKey: "data") as AnyObject).value(forKey: "locationUser") as! String), for: .normal)
                
            self.title2_lbl.setTitle(self.Distance, for: .normal)
                
    self.latitute = ((json.object(forKey: "data") as AnyObject).value(forKey: "lati") as! Double)
    self.Longitute = ((json.object(forKey: "data") as AnyObject).value(forKey: "longi") as! Double)
                
    self.GoogleMapDisplay()
                
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        NavigationShow ()
        fetchDetails()
        DisplayUI()
        
        title_lbl.SetBordor()
        Share.SetBordor()
        title1_lbl.SetBordor()
        title2_lbl.SetBordor()
        
        // Do any additional setup after loading the view.
    }

    //MARK: Display Constraint
    
    func DisplayUI()
    {
        if self.view.frame.size.height == 568 || self.view.frame.size.height == 480
        {
    bottomView.frame = CGRect(x: 0, y: upperView.frame.origin.y+upperView.frame.size.height, width: bottomView.frame.size.width, height: bottomView.frame.size.height)
            
    DetailScroll.contentSize = CGSize(width: self.view.frame.size.width, height: 425)
    }
  }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Google Maps
    
    func GoogleMapDisplay()
    {
        let camera = GMSCameraPosition.camera(withLatitude: self.latitute, longitude: self.Longitute, zoom: 15)
        self.mapview.isMyLocationEnabled = true
        self.mapview.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(self.latitute,self.Longitute)
        marker.title = self.title_article!
        marker.snippet = ""
        marker.map = mapview
    
    }


}

//
//  HomeController.swift
//  MapologyApp
//
//  Created by 34in on 20/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit
import Kingfisher
import GooglePlaces
import GoogleMaps
import SwiftyJSON

class HomeController: UIViewController,UITableViewDataSource, UITableViewDelegate,GMSAutocompleteViewControllerDelegate,UIScrollViewDelegate {

    var Pagination:String = "1"
    var latitude:String = ""
    var longitude:String = ""
    
    //MARK: Location Search
    
    
      func TapLocation() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    // Handle the user's selection.
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        print("Place Name: \(place.name)")
        
        dismiss(animated: true, completion: nil)

        latitude = ("\(place.coordinate.latitude)" as String) as String
        longitude = "\(place.coordinate.longitude)" as String
        
        print(latitude)
        print(longitude)
    }
    
    // MARK: view
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
     func RightNavigate()
     {
        let button1 = UIBarButtonItem(image: UIImage(named:"location_img.png"), style: .plain, target: self, action:#selector(HomeController.TapLocation))
        self.navigationItem.rightBarButtonItem  = button1
    
     }
    
    
    @IBOutlet var ProductTable: UITableView!
    
    
    
    @IBOutlet var TodayDate: UILabel!
    
    var tag_value:Int = 1
    
    func NavigationShow ()
    {
        self.navigationController?.navigationBar.barTintColor = GreenColor
        
        
        let button1 = UIBarButtonItem(image: UIImage(named:"side.png"), style: .plain, target: self, action:#selector(ViewController.Left))
        self.navigationItem.leftBarButtonItem  = button1
        
     
        
        self.navigationController?.navigationBar.addSubview(NavigationTitle(size: self.view))
    }
    
    func ratingButtonTapped(sender:UIButton!)
    {
    
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
    
    func TopHeader()
    {
        var x_value:CGFloat = 0
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height:45))
        
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        
        for i in 1..<6
        {
        
        let view_btn = UIView()
        view_btn.frame = CGRect(x: x_value, y: 0, width: 110, height:45)
        view_btn.alpha = 0.0
        view_btn.tag = i
        scroll.addSubview(view_btn)
            
        let button = UIButton()
        button.frame = CGRect(x: x_value, y: 0, width: 110, height:45)
        button.tag = i
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        scroll.addSubview(button)
            
            if i==1
            {
            tag_value = 1
            view_btn.bottomBorder(color: GreenColor, width: 2.5)
                view_btn.alpha = 1.0
             button.setTitle("All Offers", for: .normal)
                   x_value += 110
            }
            
            if i==2
            {
                view_btn.bottomBorder(color:PinkColor, width: 2.5)
                button.setTitle("Coffee Shops", for: .normal)
                   x_value += 110
            }
            
            if i==3
            {
                view_btn.bottomBorder(color: BlueColor, width: 2.5)
                button.setTitle("Restaurants", for: .normal)
                x_value += 110
            }
            
            if i==4
            {
        button.frame = CGRect(x: x_value, y: 0, width: 90, height:45)
        view_btn.frame = CGRect(x: x_value, y: 0, width: 90, height:45)
                
        view_btn.bottomBorder(color: YellowColor, width: 2.5)
        button.setTitle("Pubs", for: .normal)
        x_value += 90
            }
            
            if i==5
            {
        button.frame = CGRect(x: x_value, y: 0, width: 90, height:45)
        view_btn.frame = CGRect(x: x_value, y: 0, width: 90, height:45)
                
        view_btn.bottomBorder(color: PinkColor2, width: 2.5)
                
        button.setTitle("Fast Food", for: .normal)
        x_value += 90
           
            }
        }
        
        scroll.contentSize = CGSize(width: x_value, height:45)
        
    }
    
    
     func pressButton(button: UIButton) {
        
      //  print(button.tag)
     //   print(tag_value)
        
        if let view_btn = self.view.viewWithTag(tag_value)
        {
               view_btn.alpha = 0.0
        }
      
        if let view_btn2 = self.view.viewWithTag(button.tag)
        {
            view_btn2.alpha = 1.0
            tag_value = button.tag
      
        }
        
        if button.tag == 1
        { selectedOffer = "all"
        self.navigationController?.navigationBar.barTintColor = GreenColor
        }
            
        else  if button.tag == 2
        { selectedOffer = "coffee-shop"
        self.navigationController?.navigationBar.barTintColor = PinkColor
        }
        
        else  if button.tag == 3
        {selectedOffer = "restaurant"
        self.navigationController?.navigationBar.barTintColor = BlueColor
        }
        
        else  if button.tag == 4
        {selectedOffer = "pub"
        self.navigationController?.navigationBar.barTintColor = YellowColor
        }
        
        else  if button.tag == 5
        {selectedOffer = "fast-food"
        self.navigationController?.navigationBar.barTintColor = PinkColor2
        }
        
        Pagination = "1"
        
        Offer_Fetch(type: selectedOffer)
    }
    
   var pagingSpinner = UIActivityIndicatorView()
    
    func loaderPagination()
    {
                 pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                pagingSpinner.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
                pagingSpinner.hidesWhenStopped = true
        
                ProductTable.tableFooterView = pagingSpinner
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductLbl.isHidden = true
        
        loaderPagination()
        
         NavigationShow ()
         RightNavigate ()
        
         TopHeader()
        
         selectedOffer = "all"
         Offer_Fetch(type: selectedOffer)
        
        TodayDate.text = "Today  " + CurrentDate()
        
    self.automaticallyAdjustsScrollViewInsets = false

//self.view.addGestureRecognizer(self.slidingViewController().panGesture)
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITableView Delegate Methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return articleObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:HomeCell = ProductTable .dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
       cell.selectionStyle = .none
    
        let type = self.articleObj[indexPath.row] as! ArticleModel
        
       // print(type.distance)
        
        let url = URL(string: ProductImagePath + (type.coverImage as String))!
        
        cell.img.kf .setImage(with: url, placeholder:UIImage (named: "placehoderUser.png"))
        
        cell.type.text = type.category as String
        
      //  var distance_km = ((self.arrayValue.object(at: indexPath.row) as AnyObject).value(forKey: "distance") as! Double)
        
      //  distance_km = distance_km * 1.609344
        
         cell.distance.text = String(type.distance as Float) + " M"
        
         cell.title.text = type.title as String
        
     //  cell.bg_view.backgroundColor = UIColor.darkGray
        
        cell.follow.addTarget(self, action: #selector(Followbtn), for: .touchUpInside)
        
        cell.follow.tag = indexPath.row + 1001
        
        print(type.category)
        print(type.followed)
        print(type.title)
        
        
        if  type.followed > 0 && type.category == "fast-food"
        {
        cell.follow.setBackgroundImage(UIImage(named:"Pink.png"), for: .normal)
        }
        
        else if type.followed > 0 && type.category == "coffee-shop"
        {
            cell.follow.setBackgroundImage(UIImage(named:"Red.png"), for: .normal)
        }
        
        else if type.followed > 0 && type.category == "pub"
        {
            cell.follow.setBackgroundImage(UIImage(named:"Yellow.png"), for: .normal)
        }
        
        else if type.followed > 0 && type.category == "restaurant"
        {
            cell.follow.setBackgroundImage(UIImage(named:"Cyan.png"), for: .normal)
        }
        
        else if type.followed > 0 && type.category == ""
        {
        cell.follow.setBackgroundImage(UIImage(named:"Cyan.png"), for: .normal)
        }
        else
        {
        cell.follow.setBackgroundImage(UIImage(named:"White.png"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let id_article = (self.articleObj.object(at: indexPath.row)) as! ArticleModel
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") as! DetailController
        
        detailVC.ArticleID = id_article.ids_arr
        detailVC.Distance = "Distance " + String(describing: ((self.arrayValue.object(at: indexPath.row) as AnyObject).value(forKey: "distance") as! Double)) + " M"
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
     //MARK: ScrollView Delegate Methods
    
    @IBOutlet var ProductLbl: UILabel!
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
        {
    
            //Bottom Refresh
    
            if scrollView == ProductTable{
    
                if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
                {
                    if (self.arrayValue.count%15 == 0)
                    {
                     pagingSpinner.startAnimating()
                var page_number = Int(Pagination)!
                page_number = page_number + 1
                Pagination = String(describing: page_number)

                // print("Page number is  ",Pagination)
                  
                    LoadMore(type: selectedOffer)
                    pagingSpinner.startAnimating()
                    
                    }
                }
            }
        }
    
    
    func Followbtn (_sender:UIButton)
    {
        print(_sender.tag)
        
         print(self.articleObj.count)
        
        let tagValue = _sender.tag - 1001
        
        let obj = self.articleObj.object(at: tagValue) as! ArticleModel
        
        MbprogressHudShow(self.view)
        
        let params = FollowArticle(art_id: obj.ids_arr)
        
        APIInstance.postDatatoServer(SaveFollowArticleAPI, parameter: params, success: { (response) in
            
         // print(response)
            
            let data = try! response.rawData()
            
            let json:NSDictionary = serialization(data: data)
            
            if json.value(forKey: "status")as! NSNumber == 1
            {
               
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

        let article = self.articleObj[tagValue] as! ArticleModel
        article.followed = 1
        self.articleObj[tagValue] = article
        
//         let type = ArticleModel(self.arrayValue.object(at: tagValue) as! NSDictionary)

         ProductTable.reloadData()
        
//        if let btnFollow = self.view.viewWithTag(_sender.tag) as? UIButton
//        {
//    btnFollow.setBackgroundImage(UIImage(named:"Green.png"), for: .normal)
//
////        let arr = self.arrayValue[tagValue] as! NSMutableArray
////        self.arrayValue.removeObject(at: tagValue)
//
//        }
    }
    
    //MARK: Fetching Offers
    
    var json:NSDictionary = NSDictionary()
    var arrayValue:NSMutableArray = NSMutableArray()
    var articleObj:NSMutableArray = NSMutableArray()
    
     func Offer_Fetch(type:String)
    {
    MbprogressHudShow(self.view)
        
    let params = OfferData(type: selectedOffer)
    articleObj = NSMutableArray()
        
     //  print(params)
        
        APIInstance.postDatatoServer(ArticlesAPI + Pagination, parameter: params, success: { (response) in
            
            let data = try! response.rawData()

             self.json = serialization(data: data)
            
             self.arrayValue = (self.json.value(forKey: "data")as! NSArray).mutableCopy() as! NSMutableArray
            
           // print("Data  ->  \(self.arrayValue)")
            
            for var i in 0..<self.arrayValue.count
            {
             let type = ArticleModel(self.arrayValue.object(at: i) as! NSDictionary)
             self.articleObj.add(type)
            }
            
            if self.arrayValue.count == 0
            {
            self.ProductLbl.isHidden =  false
            }
            else
            {
             self.ProductLbl.isHidden =  true
            }

//            print(self.arrayValue.count)
           
              print(self.arrayValue)
            
        
              self.pagingSpinner.stopAnimating()
            
            if self.json.value(forKey: "status")as! NSNumber == 1
            {
              dissmissHUD(self.view)
                
              self.ProductTable.reloadData()
            }
            else
            { dissmissHUD(self.view)
           //   alertshow(message: json.value(forKey: "slug")as! String, title: "Warning!", view: self)
            }
            
          }) { (error) in
            
            print(error.localizedDescription)
            
            dissmissHUD(self.view)
            
        }

    }
    
    
    func LoadMore(type:String)
    {
        let params = OfferData(type: selectedOffer)
        
        APIInstance.postDatatoServer(ArticlesAPI + Pagination, parameter: params, success: { (response) in
            
            let data = try! response.rawData()
            
            self.json = serialization(data: data)
            
            let tempArray = (self.json.value(forKey: "data")as! NSArray).mutableCopy() as! NSMutableArray
            
            for var i in 0..<tempArray.count
            {
                let type = ArticleModel(tempArray.object(at: i) as! NSDictionary)
                self.articleObj.add(type)
            }

            
    // let mergedArray = self.arrayValue.addingObjects(from: tempArray as [AnyObject])
   //  self.arrayValue = (mergedArray as NSArray).mutableCopy() as! NSMutableArray
            
            
            self.pagingSpinner.stopAnimating()
            
            if self.json.value(forKey: "status")as! NSNumber == 1
            {
                self.ProductTable.reloadData()
            }
            else
            { dissmissHUD(self.view)
         
            }
            
        }) { (error) in
            
            print(error.localizedDescription)
            
            
        }
        
    }
    
    
}

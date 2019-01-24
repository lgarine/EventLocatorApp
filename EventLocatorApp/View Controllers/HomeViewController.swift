//
//  HomeViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 10/30/18.
//  Copyright © 2018 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit
import Contacts
import CoreLocation

class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,LocationSelectionViewControllerDelegate {
    
    var imagesArray:NSArray = [] ;
    var categoryTextArray:NSArray = [] ;
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var eventListTable: UITableView!
    
    var chooseLocationButton:UIButton?
    var currentLocationName:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        categoryCollectionView.register(UINib(nibName: "NewCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCategoryCollectionViewCell")
        
        eventListTable.register(UINib(nibName: "EventListTableViewCell", bundle: nil), forCellReuseIdentifier: "EventListTableViewCell")
        eventListTable.rowHeight = 170;
        
        imagesArray = NSArray(objects: UIImage(named: "icon-spiritual")!,UIImage(named: "icon-entertinement")!,UIImage(named: "icon-education")!,UIImage(named: "icon-medical")!,UIImage(named: "icon-social")!,UIImage(named: "icon-family")!)
        
        categoryTextArray = NSArray(objects: "Spiritual","Entertinement","Educational","Medical","Social","Family")
        categoryCollectionView.backgroundColor = UIColor.darkGray;
        
      
        
         self.getCurrentlocation()
        self.getDataFromUrl()
        
        self.setUI()
        
    }
    
    func setUI()
    {
        self.chooseLocationButton = UIButton(frame: CGRect(x: 0, y: 0, width: 130, height: 44))
        chooseLocationButton?.titleLabel?.textAlignment = .center
        //self.chooseLocationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.chooseLocationButton?.setTitle("Location", for: UIControlState.normal)
        
        if let font = UIFont(name: "Archer-Semibold", size: 19.0) {
            chooseLocationButton?.titleLabel?.font = font
        }
        self.chooseLocationButton?.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        
        chooseLocationButton?.addTarget(self, action: #selector(locationSelection), for: .touchUpInside)
        
        navigationItem.titleView = chooseLocationButton
        
        
    }
    
    
    func getCurrentlocation()
    {
       
        Locationmanager.sharedInstance.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if error != nil {
//                self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
                
                print((error?.localizedDescription)!)
                
                return
            }
            guard let _ = location else {
                return
            }
            print(placemark?.administrativeArea ?? "")
            print(placemark?.name ?? "")
            print(placemark?.country ?? "")
            print(placemark?.areasOfInterest ?? "")
            print(placemark?.isoCountryCode ?? "")
            print("Location is",placemark?.location ?? "")
            print("Locality is",placemark?.locality ?? "")
            print(placemark?.subLocality ?? "")
            print(placemark?.postalCode ?? "")
            print(placemark?.timeZone ?? "")
            print(placemark?.addressDictionary?.description ?? "")
            
            let address = placemark?.addressDictionary?["FormattedAddressLines"] as! NSArray
           // self.addressLabel.text = address.description
            
        //    self.locationButton.titleLabel?.text = placemark?.locality
            
   self.chooseLocationButton?.setTitle(placemark?.locality, for: UIControlState.normal)
                
            
//            self.latitudeLabel.text = "\((placemark?.location?.coordinate.latitude)!)"
//            self.longitudeLabel.text = "\((placemark?.location?.coordinate.longitude)!)"
        }
    }
    
    
    func getDataFromUrl(){
        
        //get data from 
        
    }
    
    @objc func locationSelection()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LocationSelectionViewController") as! LocationSelectionViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        
        nextViewController.delegate = self;
        
        let pesentingNavigationController = UINavigationController(rootViewController: nextViewController)
        self.present(pesentingNavigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func menuButtonAction(_ sender: Any) {
        
    self.sideMenuViewController?.presentLeftMenuViewController()
        
    }
    @IBAction func addEventButtonAction(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        //self.navigationController?.pushViewController(nextViewController, animated: true)
        
      
        let pesentingNavigationController = UINavigationController(rootViewController: nextViewController)
        self.present(pesentingNavigationController, animated: true, completion: nil)
        
        //self.navigationController?.present(nextViewController, animated: true, completion:nil)
            
    }
    
    
    //MARK: CollectionviewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCategoryCollectionViewCell", for: indexPath) as! NewCategoryCollectionViewCell
        
        cell.categoryIcon.image = imagesArray.object(at: indexPath.row) as? UIImage
        
        cell.categoryName.text = categoryTextArray.object(at: indexPath.row) as? String
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // call a webservice to load category specific events.
    }
    
   
    
    //MARK: TableviewDelegate
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 10;
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell", for: indexPath) as! EventListTableViewCell
            
            //Temparary
//            if(categoryType == "Spiritual")
//            {
   cell.bannerImageView.image = UIImage(named: "banner-spi")
//            }
//            if(categoryType == "Entertinement")
//            {
//                cell.bannerImageView.image = UIImage(named: "banner-enter")
//            }
//            if(categoryType == "Educational")
//            {
//                cell.bannerImageView.image = UIImage(named: "banner-edu")
//            }
//            if(categoryType == "Medical")
//            {
//                cell.bannerImageView.image = UIImage(named: "banner-medical")
//            }
//            if(categoryType == "Social")
//            {
//                cell.bannerImageView.image = UIImage(named: "banner-social")
//            }
//            if(categoryType == "Family")
//            {
//                cell.bannerImageView.image = UIImage(named: "banner-family")
//            }
//
            return cell;
            
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "eventDetailViewController") as! eventDetailViewController
      self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

    
    //MARK:- LocationSelectionViewControllerDelegate
    
    func LocationSelectionVCIsDone(city: String?) {
        
         self.chooseLocationButton?.setTitle(city, for: UIControlState.normal)
        
    }
    
    
    
}

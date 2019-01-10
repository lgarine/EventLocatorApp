//
//  HomeViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 10/30/18.
//  Copyright © 2018 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit
import Contacts

class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    var imagesArray:NSArray = [] ;
    var categoryTextArray:NSArray = [] ;
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var eventListTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        categoryCollectionView.register(UINib(nibName: "NewCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCategoryCollectionViewCell")
        
        eventListTable.register(UINib(nibName: "EventListTableViewCell", bundle: nil), forCellReuseIdentifier: "EventListTableViewCell")
        eventListTable.rowHeight = 170;
        
        imagesArray = NSArray(objects: UIImage(named: "icon-spiritual")!,UIImage(named: "icon-entertinement")!,UIImage(named: "icon-education")!,UIImage(named: "icon-medical")!,UIImage(named: "icon-social")!,UIImage(named: "icon-family")!)
        
        categoryTextArray = NSArray(objects: "Spiritual","Entertinement","Educational","Medical","Social","Family")
        categoryCollectionView.backgroundColor = UIColor.darkGray;
        
        self.getDataFromUrl();
        
    
    }
    
    
    func getCurrentlocation()
    {
        
    }
    
    func getDataFromUrl(){
        
        //get data from 
        
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
        
//        if(tableView == dropDownTable)
//        {
//            return (citylist?.count)!;
//        }
//        else
//        {
            return 10;
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        if(tableView == eventListTable)
//        {
        
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
            
//        }
//        else
//        {
//            let    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//
//
//            cell.textLabel?.text = citylist?.object(at: indexPath.row) as? String;
//            return cell;
//        }
        
        
    }
    

 

}

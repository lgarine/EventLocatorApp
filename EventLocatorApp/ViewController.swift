//
//  ViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 10/7/18.
//  Copyright © 2018 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var imagesArray:NSArray = [] ;
    var categoryTextArray:NSArray = [] ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        categoryCollectionView.register(UINib(nibName: "categoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCollectionViewCell")
        
        imagesArray = NSArray(objects: UIImage(named: "icon-spiritual")!,UIImage(named: "icon-entertinement")!,UIImage(named: "icon-education")!,UIImage(named: "icon-medical")!,UIImage(named: "icon-social")!,UIImage(named: "icon-family")!)
        
        categoryTextArray = NSArray(objects: "Spiritual","Entertinement","Educational","Medical","Social","Family")
        
    }
    
    
    @IBAction func menuButtonAction(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! categoryCollectionViewCell
        
        cell.categoryIcon.image = imagesArray.object(at: indexPath.row) as? UIImage
        
        cell.categoryLabel.text = categoryTextArray.object(at: indexPath.row) as? String
        return cell;
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EventListViewController") as! EventListViewController
//        nextViewController.categoryType = self.categoryTextArray.object(at: indexPath.row) as? String;
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


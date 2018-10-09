//
//  EventListViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 10/7/18.
//  Copyright © 2018 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var selectcityButton: UIButton!
    @IBOutlet weak var dropDownTable: UITableView!
    
    @IBOutlet weak var eventListTable: UITableView!
    
    var categoryType:String?
    
    var isDrop:Bool = true;
    
    var citylist:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        eventListTable.register(UINib(nibName: "EventListTableViewCell", bundle: nil), forCellReuseIdentifier: "EventListTableViewCell")
        eventListTable.rowHeight = 170;
        
        dropDownTable.isHidden = true;
        citylist = NSArray(objects: "Select City","Kansas","Chicago","Dallas","New York","CA","NC","DC")
        
        print("new test line for checking commit");
        
    }
    
    @IBAction func selectCity(_ sender: Any) {
        
        if(isDrop)
        {
            dropDownTable.isHidden = false
        }
        else
        {
            dropDownTable.isHidden = true;
        }
        isDrop = !isDrop;
        
    }
    
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == dropDownTable)
        {
            return (citylist?.count)!;
        }
        else
        {
            return 10;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(tableView == eventListTable)
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell", for: indexPath) as! EventListTableViewCell
            
            //Temparary
            if(categoryType == "Spiritual")
            {
                cell.bannerImageView.image = UIImage(named: "banner-spi")
            }
            if(categoryType == "Entertinement")
            {
                cell.bannerImageView.image = UIImage(named: "banner-enter")
            }
            if(categoryType == "Educational")
            {
                cell.bannerImageView.image = UIImage(named: "banner-edu")
            }
            if(categoryType == "Medical")
            {
                cell.bannerImageView.image = UIImage(named: "banner-medical")
            }
            if(categoryType == "Social")
            {
                cell.bannerImageView.image = UIImage(named: "banner-social")
            }
            if(categoryType == "Family")
            {
                cell.bannerImageView.image = UIImage(named: "banner-family")
            }
            
            return cell;
            
        }
        else
        {
            let    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            
            
            cell.textLabel?.text = citylist?.object(at: indexPath.row) as? String;
            return cell;
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

        if(tableView == eventListTable)
        {

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "eventDetailViewController") as! eventDetailViewController

            self.navigationController?.pushViewController(nextViewController, animated: true)
        }

        else
        {
            selectcityButton.titleLabel?.text = citylist?.object(at: indexPath.row) as? String;
            
            dropDownTable.isHidden = true;
            isDrop = !isDrop;
            
            //call webservice for fetching events in selected city

        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

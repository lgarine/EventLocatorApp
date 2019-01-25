//
//  LocationSelectionViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 1/17/19.
//  Copyright © 2019 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

protocol LocationSelectionViewControllerDelegate: class {
    func LocationSelectionVCIsDone(city:String?)
}

class LocationSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: LocationSelectionViewControllerDelegate?
      var rightBarButton:UIBarButtonItem?
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let sectionArray = ["Country", "State", "City"]
    let cellArray = [
        ["USA", "India", "Australia"],
        ["Kansas", "SFO", "Arizona", "Nebraska"],
        ["Overland Park", "Freemont", "Omaha", "Lees Summit", "Lenexa"]
    ]
    var isShowing = [false, false, false]
    var selectedIndex = [0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rightBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButtonAction))
        
        self.navigationItem.rightBarButtonItem = self.rightBarButton
       
        // Do any additional setup after loading the view.
    }
    
    
    @objc func doneButtonAction()
    {
        
//   delegate?.LocationSelectionVCIsDone(city: "Kansas")
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        //return self.sectionArray.count
        return self.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.isShowing[section] {
            return 1;
        } else {
            return self.cellArray[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionArray[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        
        if !self.isShowing[indexPath.section] {
            cell?.textLabel?.text = self.cellArray[indexPath.section][self.selectedIndex[indexPath.section]]
            cell?.accessoryType = .disclosureIndicator
        } else {
            cell?.textLabel?.text = self.cellArray[indexPath.section][indexPath.row]
            if indexPath.row == self.selectedIndex[indexPath.section] {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
        }
        
        return cell!
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        if self.isShowing[indexPath.section] {
            self.selectedIndex[indexPath.section] = indexPath.row
            
            let arr1 = self.cellArray[2]
            
             delegate?.LocationSelectionVCIsDone(city: arr1[indexPath.row] )
            
        }
        self.isShowing[indexPath.section] = !self.isShowing[indexPath.section]
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    }
}

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

class LocationSelectionViewController: UIViewController {

    
    weak var delegate: LocationSelectionViewControllerDelegate?
      var rightBarButton:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rightBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButtonAction))
        
        self.navigationItem.rightBarButtonItem = self.rightBarButton
       
        // Do any additional setup after loading the view.
    }
    
    
    @objc func doneButtonAction()
    {
        
//    delegate?.LocationSelectionVCIsDone(city: "Kansas")
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

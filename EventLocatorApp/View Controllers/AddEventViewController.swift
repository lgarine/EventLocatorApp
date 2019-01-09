//
//  AddEventViewController.swift
//  EventLocatorApp
//
//  Created by Lakshmi Prasanna Garine on 1/2/19.
//  Copyright © 2019 Lakshmi Prasanna Garine. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
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

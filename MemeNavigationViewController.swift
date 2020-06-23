//
//  MemeNavigationViewController.swift
//  MemeMe
//
//  Created by Bharani Nammi on 6/15/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class MemeNavigationViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(startOver))
    }

    @objc func startOver() {
        
       // performSegue(withIdentifier: "ViewController", sender: self)
        

    }
}

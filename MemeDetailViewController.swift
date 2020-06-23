//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Bharani Nammi on 6/15/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {

// MARK: Properties
    
    
    var meme: Meme!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           //self.tabBarController?.tabBar.isHidden = true
        self.imageView.image = meme?.memedImage
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false
       }
    

}


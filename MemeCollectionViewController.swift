//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Bharani Nammi on 6/15/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit



let appDelegate = UIApplication.shared.delegate as! AppDelegate
var memes = appDelegate.memes
   
class MemeCollectionViewController: UICollectionViewController {

    // MARK: Properties
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances.
   
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        //cell.nameLabel.text = meme.name
        //cell.villainImageView?.image = UIImage(named: meme.imageName)
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        cell.MemeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}

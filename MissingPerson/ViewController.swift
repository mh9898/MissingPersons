//
//  ViewController.swift
//  MissingPerson
//
//  Created by MiciH on 6/2/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedImg: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    var baseUrl = "http://localhost:6069/img/"
    var imageUrls = [
        "person1.jpg",
        "person2.jpg",
        "person3.jpg",
        "person4.jpg",
        "person5.jpg",
        "person6.png"
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: "loadPicker:")
        tap.numberOfTapsRequired = 1
        selectedImg.addGestureRecognizer(tap)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonCell", forIndexPath:indexPath) as! PersonCell
        
        let url = "\(baseUrl)\(imageUrls[indexPath.row])"
        
        cell.configCell(url)
        
        return cell
    }

    @IBAction func checkForMatch(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //picking an image form the photos
        if let pickecdImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImg.image = pickecdImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadPicker(gesture: UIGestureRecognizer){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary // use .camera on the phone
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
   

}


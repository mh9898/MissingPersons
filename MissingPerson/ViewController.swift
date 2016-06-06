//
//  ViewController.swift
//  MissingPerson
//
//  Created by MiciH on 6/2/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit
import ProjectOxfordFace

let baseUrl = "http://localhost:6069/img/"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //selected person from the collection view
    var selectedPerson : Person?
    
    //bool for alert
    var boolSelectedImage = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedImg: UIImageView!
    
    let imagePicker = UIImagePickerController()
 
    var missingPepole = [
        Person(personImageUrl: "person1.jpg"),
        Person(personImageUrl: "person2.jpg"),
        Person(personImageUrl: "person3.jpg"),
        Person(personImageUrl: "person4.jpg"),
        Person(personImageUrl: "person5.jpg"),
        Person(personImageUrl: "person6.png"),
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
        return missingPepole.count
    }
    
    //loading the custom cell from Person Cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonCell", forIndexPath:indexPath) as! PersonCell
        
        //which person was selected in which row
        let person = missingPepole[indexPath.row]
        
        //get the person url form confg cell
        cell.configCell(person)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedPerson = missingPepole[indexPath.row]
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PersonCell
        
        cell.configCell(selectedPerson!)

        cell.setSelected()

    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedPerson = missingPepole[indexPath.row]
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PersonCell
        
        cell.configCell(selectedPerson!)
        
        cell.notSelected()
        
    }
    
    
    func errorAlet(){
        let alert = UIAlertController(title: "Select Person / Image", message: "please select a person to dedect", preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(ok)
        
        presentViewController(alert, animated: true, completion: nil)

    }
    
    func alertPerson (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(ok)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }

    
    @IBAction func checkForMatch(sender: AnyObject) {
        
        if selectedPerson == nil || !boolSelectedImage  {
            errorAlet()
        }
        else{
            
            if let img = selectedImg.image, let imgData = UIImageJPEGRepresentation(img, 0.8){
                
                FaceSerivce.instance.client.detectWithData(imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces:[MPOFace]!, err: NSError!) -> Void in
                    
                    if err == nil {
                        var faceId: String?
                        for face in faces{
                            faceId = face.faceId
                            break
                        }
                        
                        if faceId != nil{
                            
                            FaceSerivce.instance.client.verifyWithFirstFaceId(self.selectedPerson!.faceId, faceId2: faceId, completionBlock: { (result: MPOVerifyResult!, err: NSError!) -> Void in
                            
                                if err == nil{
                                    
                                    if result.isIdentical == true{
                                        
                                       self.alertPerson("match", message: "dedectPerson")
                                    }
                                    else{
                                        self.alertPerson("No match", message: "try again")
                                    }
                                    
                                    print(result.confidence)
                                    print(result.isIdentical)
                                    
                                    
                                    
                                }
                                else{
                                    print(err.debugDescription)
                                }

                            })
                            
                        }
                    }
                    
                })
            }
        }
        
        
        
    }
    
    
    ///image picker /////
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //picking an image form the photos
        if let pickecdImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImg.image = pickecdImage
            boolSelectedImage = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadPicker(gesture: UIGestureRecognizer){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary // use .camera on the phone
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
   

}


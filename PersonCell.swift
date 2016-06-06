//
//  PersonCell.swift
//  MissingPerson
//
//  Created by MiciH on 6/2/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    
    @IBOutlet weak var personImage: UIImageView!
    
    var currentFaceId : String?
    
    var person: Person!
    
    var boolCurrentImage = false
    
    
    func configCell(person: Person){
        
//        downloadImage(NSURL(string: imageUrl)!)
        self.person = person
        
        if let url = NSURL(string: "\(baseUrl)\(person.personImageUrl!)"){
            downloadImage(url)
        }
        
    }
    
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, responde: NSURLResponse?, error: NSError?) -> Void)) {
        
        //ask for the image data respond and error
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, respond, error) in
            completion(data: data, responde: respond, error: error)
            }
            //start the request
            .resume()
    }

    
    func downloadImage(url: NSURL){
        getDataFromUrl(url) { (data, responde, error) in
            // if we have data and there is no error
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                self.personImage.image = UIImage(data: data)
                
                self.person.personImage = self.personImage.image
            }
            
        }
    }
    
    func setSelected(){

        print(person.faceId)
        personImage.layer.borderWidth = 2.0
        personImage.layer.borderColor = UIColor.yellowColor().CGColor
        self.person.downloadFaceId()
 
    }
    
    func notSelected(){
        
        print(person.faceId)
        personImage.layer.borderWidth = 0.0
                
    }

    
    
}




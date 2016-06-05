//
//  Person.swift
//  MissingPerson
//
//  Created by MiciH on 6/5/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class Person {
    
    var faceId : String?
    var personImage : UIImage?
    var personImageUrl: String?
    
    
    func downloadFaceId() {
        
        if let img = personImage, let imgData = UIImageJPEGRepresentation(img, 0.8){
            
        }
    }
    
}

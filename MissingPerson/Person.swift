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
    
    init(personImageUrl: String){
        self.personImageUrl = personImageUrl
    }
    
    
    func downloadFaceId() {
        
        if let img = personImage, let imgData = UIImageJPEGRepresentation(img, 0.8){
            FaceSerivce.instance.client.detectWithData(imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces:[MPOFace]!,err: NSError!) -> Void in
                
                if err == nil{
                    var faceId: String?
                    for face in faces{
                        faceId = face.faceId
                        print("faceId: \(faceId)")
                        break
                    }
                    
                    self.faceId = faceId
                }
                
            })
        }
    }
    
}

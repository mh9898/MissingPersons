//
//  FaceService.swift
//  MissingPerson
//
//  Created by MiciH on 6/5/16.
//  Copyright © 2016 MichaelH. All rights reserved.
//

import Foundation
import ProjectOxfordFace

class FaceSerivce {
    
    static let instance = FaceSerivce()
    
    let client = MPOFaceServiceClient(subscriptionKey: "737e22377e584abe9257bdfebb3ee001")
    
}

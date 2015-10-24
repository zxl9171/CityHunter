//
//  PreyData.swift
//  CityHunter
//
//  Created by Xing Yichi on 10/24/15.
//  Copyright © 2015 xing. All rights reserved.
//

import Foundation
import MapKit

class PreyData: NSObject {
    
    
    //the array of the prey data:
    var preyData:[CLLocationCoordinate2D] = []
    var preyNameData:[String] = []
    

    // From the api, get the location of the prey(s) in CLLocationCoordinate2D
    // like
    // func setPreyData(){}
    
    
    // For now this is only a pseudo-data:
    func setPreyData(){
        let pseudoCoordinate = CLLocationCoordinate2D(latitude: 34.0, longitude: -118.5)
        
        preyData.append(pseudoCoordinate)
        preyNameData.append("zhen Xiaolei")
    }
    
}

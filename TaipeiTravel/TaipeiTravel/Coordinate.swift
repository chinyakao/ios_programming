//
//  Coordinate.swift
//  TaipeiTravel
//
//  Created by mac25 on 2020/5/20.
//  Copyright © 2020 hsin. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate {
    var index: Int
    var latitude: Double
    var longitude:Double
}
extension Coordinate: Comparable {}

func ==(a:Coordinate,b:Coordinate)->Bool{
    let myUserDefaults = UserDefaults.standard
    let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
    if locationAuth != nil && locationAuth!{
        let userLatitude = myUserDefaults.object(forKey: "userLatitude") as? Double
        let userLongitude = myUserDefaults.object(forKey: "userLongitude") as? Double
        let userLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
        
        let aLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let bLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        return aLocation.distance(from: userLocation) == bLocation.distance(from: userLocation)
    }
    else{
        return a.index == b.index
    }
}
func <(a:Coordinate,b:Coordinate)->Bool{
    let myUserDefaults = UserDefaults.standard
    let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
    if locationAuth != nil && locationAuth!{
        let userLatitude = myUserDefaults.object(forKey: "userLatitude") as? Double
        let userLongitude = myUserDefaults.object(forKey: "userLongitude") as? Double
        let userLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
        
        let aLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let bLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        return aLocation.distance(from: userLocation) < bLocation.distance(from: userLocation)
    }
    else{
        return a.index < b.index
    }
}

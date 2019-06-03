//
//  RealmClass.swift
//  Meteo
//
//  Created by Massimiliano on 28/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherTableView : Object{
    
    @objc dynamic var nomeCitta : String?
    @objc dynamic var temp : Double = 0.0
    @objc dynamic var min : Double = 0.0
    @objc dynamic var max : Double = 0.0
    @objc dynamic var picture : Int = 0
}

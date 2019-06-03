//
//  JSON Structure.swift
//  Meteo
//
//  Created by Massimiliano on 26/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit


class ObjectForecast : Decodable{
    var city : City
    var list : [Main]
}

class City : Decodable {
    var id : Int
    var name : String
}


class Main : Decodable {
    var main : Temperature
    var weather : [Weather]
    var dt_txt : String
    var dt : Double
}

class Temperature : Decodable {
    var temp : Double
    var temp_min : Double
    var temp_max : Double
}


class Weather : Decodable {
    var id : Int
    var description : String
}



func getMYJsonCell (latidute : Double, longitude : Double) -> ObjectForecast{
        let data : Data = try! Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latidute)&lon=\(longitude)&APPID=b40d5e51a29e2610c4746682f85099b2")!)
    
    let my = try! JSONDecoder().decode(ObjectForecast.self, from: data)
    
    return my
}



func updateWeatherIcon(condition: Int) -> String {
    
    switch (condition) {
        
    case 0...300 :
        return "tstorm1"
        
    case 301...500 :
        return "light_rain"
        
    case 501...600 :
        return "shower3"
        
    case 601...700 :
        return "snow4"
        
    case 701...771 :
        return "fog"
        
    case 772...799 :
        return "tstorm3"
        
    case 800 :
        return "sunny"
        
    case 801...804 :
        return "cloudy2"
        
    case 900...903, 905...1000  :
        return "tstorm3"
        
    case 903 :
        return "snow5"
        
    case 904 :
        return "sunny"
        
    default :
        return "unknown"
    }
    
}




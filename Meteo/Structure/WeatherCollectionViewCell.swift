//
//  WeatherCollectionViewCell.swift
//  Meteo
//
//  Created by Massimiliano on 26/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherImageLbl: UIImageView!
    
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    
    
   
    
    
//    func setUp(coordinateLat : Double, coordinateLong : Double, indice : Int) -> ObjectForecast{
//        let data : Data = try! Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(coordinateLat)&lon=\(coordinateLong)&APPID=b40d5e51a29e2610c4746682f85099b2")!)
//
//        let my = try! JSONDecoder().decode(ObjectForecast.self, from: data)
//
//        dateAndTimeLbl.text = my.list[indice].dt_txt
//        weatherImageLbl.image = UIImage(named: updateWeatherIcon(condition: my.list[indice].weather[indice].id))
//
//        return my
//    }
    func formatter (){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
    }
   
    
    func ok (object : ObjectForecast, index : Int){
         print("indice path" , index)
        dateAndTimeLbl.text = object.list[index].dt_txt
        print("indice from func", index)
        weatherImageLbl.image = UIImage(named: updateWeatherIcon(condition: object.list[index].weather[0].id))
        print("Image from cell \(object.list[index].weather[0].id)")
    }
}

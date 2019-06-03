//
//  CityCell.swift
//  Meteo
//
//  Created by Massimiliano on 28/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class CityCell: UITableViewCell {
    
    @IBOutlet weak var imageWeather: UIImageView!
    
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempMinMaxLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCityCell(citta : WeatherTableView){
        let me = updateCellFromRealForecast(citta: citta.nomeCitta!)
        imageWeather.image? = UIImage(named: updateWeatherIcon(condition: me.picture))!
        temperatureLbl.text = "Temperature: \((me.temp - 273.15).twoDecimalNumbers(place: 1))"
        cityLbl.text = me.nomeCitta
        tempMinMaxLbl.text = "Max: \((me.max -  273.15).twoDecimalNumbers(place: 1))   Min: \((me.min - 273.15).twoDecimalNumbers(place: 1))"
    }

    
    
    func updateCellFromRealForecast(citta : String) -> WeatherTableView{
         let data : Data = try! Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(String(describing: citta))&APPID=b40d5e51a29e2610c4746682f85099b2")!)
            print(data)
            let myJSON = try! JSONDecoder().decode(ObjectForecast.self, from: data)
            let realm = try! Realm.init()
            let user = WeatherTableView.init()
            try! realm.write {
                user.nomeCitta = myJSON.city.name
                user.temp = myJSON.list[0].main.temp
                user.max = myJSON.list[0].main.temp_max
                user.min = myJSON.list[0].main.temp_min
                user.picture = myJSON.list[0].weather[0].id
            }
        
        return user
    }
}

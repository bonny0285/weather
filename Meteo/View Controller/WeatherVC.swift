//
//  ViewController.swift
//  Meteo
//
//  Created by Massimiliano on 26/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {

 
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var tempMaxLbl: UILabel!
    @IBOutlet weak var tempMinLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    var listArray = 0
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    let APP_ID = "&APPID=b40d5e51a29e2610c4746682f85099b2"
    let WEATHER_URL = "api.openweathermap.org/data/2.5/forecast?lat="
    var myURLForecast = "http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=b40d5e51a29e2610c4746682f85099b2"
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }


    func getMyWeather(latitude : Double, longitude : Double){
        
        do {
        let data : Data = try Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&APPID=b40d5e51a29e2610c4746682f85099b2")!)
           
            let myJSON = try JSONDecoder().decode(ObjectForecast.self, from: data)
            locationLbl.text = myJSON.city.name
            temperatureLbl.text = "Temperture: \((myJSON.list[0].main.temp - 273.15).twoDecimalNumbers(place: 1))"
            tempMaxLbl.text = "Max: \((myJSON.list[0].main.temp_max - 273.15).twoDecimalNumbers(place: 1))"
            tempMinLbl.text = "Min: \((myJSON.list[0].main.temp_min - 273.15).twoDecimalNumbers(place: 1))"
            weatherImage.image = UIImage(named: updateWeatherIcon(condition: myJSON.list[0].weather[0].id))
            print("Image from BG \(myJSON.list[0].weather[0].id)")
            
                print(data)
                print(myJSON.city.name)
                print(myJSON.list[0].weather[0].id)
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func getMYJson (latidute : Double, longitude : Double) -> ObjectForecast{
        let data : Data = try! Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latidute)&lon=\(longitude)&APPID=b40d5e51a29e2610c4746682f85099b2")!)
        
        let my = try! JSONDecoder().decode(ObjectForecast.self, from: data)
        
        return my
    }
}



extension WeatherVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let lat = Double(latitudeLbl.text!)
        let long = Double(longitudeLbl.text!)
        let myJSON = getMYJson(latidute: lat ?? 0.0, longitude: long ?? 0.0)
        return myJSON.list.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell)!
        let lat = Double(latitudeLbl.text!)
        let long = Double(longitudeLbl.text!)
        let myJSON = getMYJson(latidute: lat ?? 0.0, longitude: long ?? 0.0)
        cell.ok(object: myJSON, index: indexPath.row)
        return cell
    }
    

}



extension WeatherVC : CLLocationManagerDelegate{
    
    //didUpdateLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("longitude: \(location.coordinate.longitude), latitude: \(location.coordinate.latitude)")
            let latitude = Double(location.coordinate.latitude).twoDecimalNumbers(place: 4)
            let longitude = Double(location.coordinate.longitude).twoDecimalNumbers(place: 4)
            
            latitudeLbl.text = "Latitude: \(latitude.twoDecimalNumbers(place: 2))"
            longitudeLbl.text = "Longitude: \(longitude.twoDecimalNumbers(place: 2))"
            getMyWeather(latitude: latitude.twoDecimalNumbers(place: 4), longitude: longitude.twoDecimalNumbers(place: 4))
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

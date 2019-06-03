//
//  CityVC.swift
//  Meteo
//
//  Created by Massimiliano on 28/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class CityVC: UIViewController {
    
    @IBOutlet weak var textCitySearch: UITextField!
    let myURLRequest = "http://api.openweathermap.org/data/2.5/forecast?q=nepi&APPID=b40d5e51a29e2610c4746682f85099b2"
    
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.reloadData()
        print("cartella Realm", Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    
    @IBAction func searchBtnWasPressed(_ sender: Any) {
        
        getMyWeather(city_name: textCitySearch.text!.trimmingCharacters(in: .whitespaces))
       cityTableView.reloadData()
        tapGestureRecognize()
        self.view.endEditing(true)
    }
    
    
    func tapGestureRecognize(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rimuoviTastiera))
        view.addGestureRecognizer(tap)
    }
    
    @objc func rimuoviTastiera(){
        self.view.endEditing(true)
    }
    
    func createUser(nome : String, temp : Double, min : Double, max : Double, image : Int){
        do {
            let realm = try Realm.init()
            let user = WeatherTableView.init()
            user.nomeCitta = nome
            user.temp = temp
            user.max = max
            user.min = min
            user.picture = image
            try realm.write {
                print("user inserito")
                realm.add(user)
            }
        } catch{
            print(error.localizedDescription)
        }
    }
    
    
    func getWeatherForTable () -> [WeatherTableView]{
        var arrayUser: [WeatherTableView] = []
        do {
            let realm = try Realm.init()
            let result = realm.objects(WeatherTableView.self)
            for i in result{
                arrayUser.append(i)
            }
        } catch{
            print(error.localizedDescription)
        }
        return arrayUser
    }
    
    func getMyWeather(city_name : String){
        do {
              let data : Data = try Data.init(contentsOf: URL.init(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(city_name)&APPID=b40d5e51a29e2610c4746682f85099b2")!)
            print(data)
            let myJSON = try JSONDecoder().decode(ObjectForecast.self, from: data)
            createUser(nome: myJSON.city.name, temp: myJSON.list[0].main.temp, min: myJSON.list[0].main.temp_min, max: myJSON.list[0].main.temp_max, image: myJSON.list[0].weather[0].id)
            textCitySearch.text = ""
            textCitySearch.placeholder = "Find your City"
            print(myJSON.city.name)
            print(myJSON.list[0].main.temp)
            print(myJSON.list[0].main.temp_min)
            print(myJSON.list[0].main.temp_max)
            print(myJSON.list[0].weather[0].id)
        } catch {
            print(error.localizedDescription)
            
        }
        
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}


extension CityVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getWeatherForTable().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        let index = getWeatherForTable()[indexPath.row]
        cell.setupCityCell(citta: index)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeCity(atIndexPath: indexPath)
            //self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return [deleteAction]
    }
    
    func removeCity(atIndexPath indexPath: IndexPath){
        do {
            let realm = try Realm.init()
          //  let user = WeatherTableView.init()
            let result = realm.objects(WeatherTableView.self)
            try realm.write {
                
                print("user inserito")
                realm.delete(result[indexPath.row])
            }
        } catch{
            print(error.localizedDescription)
        }
    }
}

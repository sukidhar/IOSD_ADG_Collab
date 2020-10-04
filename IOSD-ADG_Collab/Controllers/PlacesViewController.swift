//
//  ViewController.swift
//  IOSD-ADG_Collab
//
//  Created by Sukidhar Darisi on 4/10/20.
//

import UIKit

class PlacesViewController: UIViewController{
    
    
    ///A places table view
    @IBOutlet weak var placesTableView: UITableView!
    ///stores the cities
    var places = [WeatherModel]()
    ///Identifer of the custom CityWeatherCell Xib
    private let cellId = "cityWeatherCell"
    ///Weather manager manges the API calls and networking
    private let weatherManager = WeatherManager()
    ///stores the selected index which is reused in preparing for segue
    private var selectedIndex : Int?
    ///segue identifier for PlaceViewController
    private let segueId = "goToPlace"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTableView.delegate = self
        placesTableView.dataSource = self
        placesTableView.register(UINib(nibName: "CityWeatherCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Add New Place
    @IBAction func addPlacePressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add City", message: "will find the entered city and saves it, if it exists", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter City Name"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let textFields = alert.textFields, let textField = textFields.first,let name = textField.text{
                self.weatherManager.fetchWeather(cityname: name) { (weather, error) in
                    if error != nil{
                        let errorAlert = UIAlertController(title: "Error", message: "Couldn't find the given city in Server", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        DispatchQueue.main.async{
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                        return
                    }
                    if let weather = weather{
                        self.places.append(weather)
                    }
                    DispatchQueue.main.async {
                        self.placesTableView.reloadData()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlaceViewController{
            vc.weather = places[selectedIndex!]
        }
    }
}


//MARK: - TableView Delegate and Datasource
extension PlacesViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = places[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CityWeatherCell
        cell.cityNameLabel.text = city.cityName
        cell.temparatureLabel.text = city.temparatureString
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: segueId, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

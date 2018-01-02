//
//  HomeViewController.swift
//  WeatherBasicApp
//
//  Created by Enrico Piovesan on 2018-01-01.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconWeatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var temperatureView: UIView!

    override func loadView() {
        super.loadView()
        
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.purpleEnd.cgColor, UIColor.purpleStart.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //load weather
        loadLocalWeather()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide elements
        cityNameLabel.alpha = 0
        dateLabel.alpha = 0
        iconWeatherImageView.alpha = 0
        temperatureView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Get user position and Load local Weather
    func loadLocalWeather() {
        firstly {
            getLocation()
            }.then { (coordinates) -> Promise<Weather> in
                WeatherService(WeatherRequest(coordinates: coordinates)).getWeather()
            }.then { weather in
                self.updateWeatherData(weather)
            }.catch{ (error) in
                print("error! ")
        }
    }
    
    // MARK: Update view with weather data
    func updateWeatherData(_ weather: Weather) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.location?.city ?? "Unknow City"
            let dateFormatterHeader = DateFormatter()
            dateFormatterHeader.setLocalizedDateFormatFromTemplate("MMMM dd yyyy")
            self.dateLabel.text = dateFormatterHeader.string(from: Date())
            self.iconWeatherImageView.image = weather.condition.weatherIcon.image
            self.temperatureLabel.text = Int(weather.condition.temp).description
            self.unitLabel.text = weather.unit!.temperature
            self.statusLabel.text = weather.condition.text.uppercased()
            
            UIView.animate(withDuration: 0.5) {
                self.cityNameLabel.alpha = 1
                self.dateLabel.alpha = 1
                self.iconWeatherImageView.alpha = 1
                self.temperatureView.alpha = 1
            }
        }
    }

    // MARK: Get user location
    func getLocation() -> Promise<CLLocationCoordinate2D> {
        return Promise { fulfill, reject in
            firstly {
                CLLocationManager.promise()
                }.then { location in
                    fulfill(location.coordinate)
                }.catch { (error) in
                    reject(error)
            }
        }
    }
    
}


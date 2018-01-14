//
//  ViewController.swift
//  BattleOfGeocoding
//
//  Created by Enrico Piovesan on 2018-01-13.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

import UIKit
import PromiseKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var geocodingResults = [GeocodingResult]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tableview
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        indicator.color = .black
        tableView.tableHeaderView = indicator
        
        //test adresses
        testAddresses()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func testAddresses() {
        for address in getAddresses() {
            
            let geocodingResult = GeocodingResult(address)
            
            //initialize a NativeGeocoding Obj
            let nativeGeocoding = NativeGeocoding(address)
            
            //configure Geocoding
            let geocodingRequest = GeocodingRequest(address)
            let geocodingService = GeocodingService(geocodingRequest)
            
            firstly{
                //use native geocoding
                nativeGeocoding.geocode()
                }.then { (geocoding) -> Void in
                    geocodingResult.native = geocoding
                }.then {() -> Promise<Geocoding> in
                    //use google maps geocoding
                    geocodingService.getGeoCoding()
                }.then {(geocoding) -> Void in
                    geocodingResult.googleMaps = geocoding
                }.always {() -> Void in
                    self.addGeocodingResult(geocodingResult)
                }.catch { (error) in
                    //manage error here!
            }
        }
    }
    
    private func addGeocodingResult(_ geocodingResult: GeocodingResult) {
        self.geocodingResults.append(geocodingResult)
        if geocodingResults.count == getAddresses().count {
            tableView.reloadData()
            tableView.tableHeaderView = UIView()
        }
    }
    
    private func getAddresses() -> [String] {
        return [
            "10 Lombard Street, San Francisco",
            "7 Bay View, Ottawa",
            "London",
            "香港东路6号，5号楼，8号室",
            "Россия, 105066, г.Москва ул.",
            "Staraya Basmannaya Ulitsa, Moskva",
            "Potosí Bolivia",
            "Sikonge District",
            "Sheikh Khalifa Bin Saeed Street Dubai",
            "Baringin West Sumatra Indonesia",
            "Esrange",
            "Fv866 120 Skjervøy Norway"
        ]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geocodingResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultGeocodingCellView", for: indexPath) as! ResultGeocodingCellView
        cell.isUserInteractionEnabled = false
        cell.addressLabel.text = geocodingResults[indexPath.row].address
        let distance = geocodingResults[indexPath.row].getDistance()
        cell.distanceLabel.textColor = .red
        if distance == nil {
            cell.distanceLabel.text = "Error!"
        } else if distance! > 1000 {
            cell.distanceLabel.text = "Distance \((distance! / 1000).description)km is a different place!"
        } else {
            cell.distanceLabel.text = "Distance \(distance!.description)m"
            cell.distanceLabel.textColor = .black
        }
        
        //Google results
        cell.googleStatusLabel.sizeToFit()
        if let googleGeocoding = geocodingResults[indexPath.row].googleMaps {
            cell.googleStatusLabel.text = "Status: Ok"
            cell.googleStatusLabel.backgroundColor = .green
            cell.googleLatitudeLabel.text = googleGeocoding.coordinates.latitude.description
            cell.googleLongitudeLabel.text = googleGeocoding.coordinates.longitude.description
        } else {
            cell.googleStatusLabel.text = "Not found!"
            cell.googleStatusLabel.textColor = .white
            cell.googleStatusLabel.backgroundColor = .red
        }
        //iOS SDK results
        cell.iosStatusLabel.sizeToFit()
        if let iosGeocoding = geocodingResults[indexPath.row].native {
            cell.iosStatusLabel.text = "Status: Ok"
            cell.iosStatusLabel.backgroundColor = .green
            cell.iosLatitudeLabel.text = iosGeocoding.coordinates.latitude.description
            cell.iosLongitudeLabel.text = iosGeocoding.coordinates.longitude.description
        } else {
            cell.iosStatusLabel.text = "Not found!"
            cell.iosStatusLabel.textColor = .white
            cell.iosStatusLabel.backgroundColor = .red
        }
        
        return cell
    }
    
}


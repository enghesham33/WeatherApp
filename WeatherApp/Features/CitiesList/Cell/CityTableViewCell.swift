//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameRegionLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var remoteCity: City? {
        didSet {
            if let city = remoteCity {
                nameRegionLabel.text = "\(city.name ?? ""), \(city.region ?? "")"
                countryNameLabel.text = city.country
            }
        }
    }
    
    var localCity: CityRealm? {
        didSet {
            if let city = localCity {
                nameRegionLabel.text = "\(city.name), \(city.region)"
                countryNameLabel.text = city.country
            }
        }
    }
    
}

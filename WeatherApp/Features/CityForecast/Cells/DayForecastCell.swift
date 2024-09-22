//
//  DayForecastCell.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import UIKit
import SDWebImage

class DayForecastCell: UICollectionViewCell {

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var weatherConditionPhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerStackView.layer.cornerRadius = 8
        containerStackView.layer.borderColor = UIColor.lightGray.cgColor
        containerStackView.layer.borderWidth = 1
    }
    
    func showData(localDay: DayRealm?) {
        if let localDay {
            let date = DateManager.convertStringToDate(dateString: localDay.date, format: "yyyy-MM-dd")
            dayNameLabel.text = DateManager.convertDateToString(date: date, format: "dd/MM/yyyy")
            highTempLabel.text = "Max Temprature: \(localDay.maxtempC) C"
            lowTempLabel.text = "Min Temprature: \(localDay.mintempC) C"
            weatherDescLabel.text = "Weather is \(localDay.condition?.text ?? "")"
            weatherConditionPhotoImageView.sd_setImage(with: URL(string: "https:\(localDay.condition?.icon ?? "")"))
        }
    }
    
    func showData(remoteDay: ForecastDay?) {
        if let remoteDay {
            let date = DateManager.convertStringToDate(dateString: remoteDay.date ?? "", format: "yyyy-MM-dd")
            dayNameLabel.text = DateManager.convertDateToString(date: date, format: "dd/MM/yyyy")
            highTempLabel.text = "Max Temprature: \(remoteDay.day?.maxtempC ?? 0.0) C"
            lowTempLabel.text = "Min Temprature: \(remoteDay.day?.mintempC ?? 0.0) C"
            weatherDescLabel.text = "Weather is \(remoteDay.day?.condition?.text ?? "")"
            weatherConditionPhotoImageView.sd_setImage(with: URL(string: "https:\(remoteDay.day?.condition?.icon ?? "")"))
        }
    }

}

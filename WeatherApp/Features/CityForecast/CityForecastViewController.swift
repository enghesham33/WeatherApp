//
//  CityForecastViewController.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 22/09/2024.
//

import UIKit

protocol CityForecastViewProtocol: BaseViewProtocol {
    var viewModel: CityForecastViewModelProtocol? { get set }
    func forecastLoaded()
    func dataSaved()
}

class CityForecastViewController: BaseViewController {
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            if viewModel?.localCity != nil {
                addButton.setTitle("Refresh", for: .normal)
            } else if viewModel?.remoteCity != nil {
                addButton.setTitle("Add", for: .normal)
            } else {
                addButton.isHidden = true
            }
        }
    }
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.text = viewModel?.localCity?.name ?? viewModel?.remoteCity?.name
        }
    }
    @IBOutlet weak var forecastDataLabel: UILabel!
    @IBOutlet weak var forecastDaysCollectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "DayForecastCell",
                            bundle: nil)
            forecastDaysCollectionView.register(nib, forCellWithReuseIdentifier: "DayForecastCell")
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.82,
                                     height: 100)
            forecastDaysCollectionView.collectionViewLayout = layout
            forecastDaysCollectionView.dataSource = self
            forecastDaysCollectionView.delegate = self
        }
    }
    
    var viewModel: CityForecastViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.getCityForecast()
    }
    
    private func showForecastData() {
        forecastDataLabel.text = ""
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        if viewModel.isLocal {
            viewModel.refreshLocalForecast()
        } else {
            viewModel.saveCity()
        }
    }
}

extension CityForecastViewController: CityForecastViewProtocol {
    func forecastLoaded() {
        
        guard let viewModel = viewModel else { return }
        
        if viewModel.isLocal {
            forecastDataLabel.text = "Temprature: \(viewModel.localCityForecast?.tempC ?? 0.0) C\n\nHumidity: \(viewModel.localCityForecast?.humidity ?? 0)\n\nWind Speed: \(viewModel.localCityForecast?.windKph ?? 0.0) K/H\n\nWeather today is \(viewModel.localCityForecast?.condition?.text ?? "")"
        } else {
            forecastDataLabel.text = "Temprature: \(viewModel.remoteCityForecast?.current?.tempC ?? 0.0)C\n\nHumidity: \(viewModel.remoteCityForecast?.current?.humidity ?? 0)\n\nWind Speed: \(viewModel.remoteCityForecast?.current?.windKph ?? 0.0)K/H\n\nWeather today is \(viewModel.remoteCityForecast?.current?.condition?.text ?? "")"
        }
    }
    
    func dataSaved() {

        if viewModel?.isLocal == false {
            navigationController?.popToRootViewController(animated: true)
        } else {
            showToast(message: "Forecast data refreshed successfully")
        }
    }
}

extension CityForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.isLocal == true ? (viewModel?.localCityForecast?.days.count ?? 0) : (viewModel?.remoteCityForecast?.forecast?.forecastDays?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayForecastCell", for: indexPath) as! DayForecastCell
        if viewModel?.isLocal == true {
            cell.showData(localDay: viewModel?.localCityForecast?.days[indexPath.row])
        } else {
            cell.showData(remoteDay: viewModel?.remoteCityForecast?.forecast?.forecastDays?[indexPath.row])
        }
        return cell
    }
}

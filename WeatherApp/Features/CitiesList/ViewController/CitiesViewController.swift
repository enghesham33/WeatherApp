//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import UIKit

protocol CitiesListViewProtocol: BaseViewProtocol {
    var viewModel: CitiesListViewModelProtocol? { get set }
    func citiesLoaded()
}

class CitiesViewController: BaseViewController {
    
    @IBOutlet weak var citiesTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
            citiesTableView.register(nib, forCellReuseIdentifier: "CityTableViewCell")
            citiesTableView.dataSource = self
            citiesTableView.delegate = self
        }
    }
    @IBOutlet weak var noDataAvailableLabel: UILabel!
    
    var viewModel: CitiesListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getCitiesList()
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        navigationController?.pushViewController(Router.searchViewController(), animated: true)
    }
}

extension CitiesViewController: CitiesListViewProtocol {
    func citiesLoaded() {
        citiesTableView.isHidden = viewModel?.localCities?.isEmpty ?? true
        noDataAvailableLabel.isHidden = !(viewModel?.localCities?.isEmpty ?? true)
        if !(viewModel?.localCities?.isEmpty ?? true) {
            citiesTableView.reloadData()
        }
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.localCities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.localCity = viewModel?.localCities?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(Router.cityForecastViewController(localCity: viewModel?.localCities?[indexPath.row]), animated: true)
    }
}

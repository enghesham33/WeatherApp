//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Mayar Khaled on 21/09/2024.
//

import UIKit

protocol SearchViewProtocol: BaseViewProtocol {
    var viewModel: SearchViewModelProtocol? { get set }
    func citiesLoaded()
}

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var searchResultTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "CityTableViewCell", bundle: nil)
            searchResultTableView.register(nib, forCellReuseIdentifier: "CityTableViewCell")
            searchResultTableView.dataSource = self
            searchResultTableView.delegate = self
        }
    }
    
    var viewModel: SearchViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: SearchViewProtocol {
    func citiesLoaded() {
        searchResultTableView.isHidden = viewModel?.remoteCities?.isEmpty ?? true
        noResultsLabel.isHidden = !(viewModel?.remoteCities?.isEmpty ?? true)
        if !(viewModel?.remoteCities?.isEmpty ?? true) {
            searchResultTableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 1)
    }
        
    @objc func search() {
        guard let searchText = searchBar.text else { return }
        if !searchText.isEmpty {
            viewModel?.searchForCity(query: searchText)
        } else {
            viewModel?.remoteCities?.removeAll()
            searchResultTableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.remoteCities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.remoteCity = viewModel?.remoteCities?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(Router.cityForecastViewController(remoteCity: viewModel?.remoteCities?[indexPath.row]), animated: true)
    }
}

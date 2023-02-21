//
//  ExchangeTableVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

protocol TableSCDelegate: AnyObject {
    func getTableValue(network: String)
}


class SupportedCurrencyTableVC: UITableViewController {
    
    
    weak var tableSCDelegate: TableSCDelegate?
    
    var dataJsonSC:[JsonSupportedCurrencies] = []
        
    var filteredData: [JsonSupportedCurrencies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        
        
        
        tableView.register(SupportedCurrensyTVCell.self, forCellReuseIdentifier: SupportedCurrensyTVCell.idExchangeTVCell)
        
        
        let manager = ExchangeManager()
        manager.getSupportedCurrencies { jsonSC in
            DispatchQueue.main.async {
                self.dataJsonSC = jsonSC
                self.filteredData = self.dataJsonSC
            }
        }
        tableView.dataSource = self

        

        
    }
    
    private func configureNavView() {
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
        title = "Supported Currencies"
        
        // MARK: Search Controller
        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
        
//        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
//        searchController.navigationItem.
//        searchController.searchBar.subviews.first?.subviews.last as? UIButton = .setTitleColor(UIColor.yellow, for: .normal)
//        searchController.searchBar.appe
//        searchController.searchBar
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

        
            
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SupportedCurrensyTVCell.idExchangeTVCell, for: indexPath) as? SupportedCurrensyTVCell
        
        cell?.configure(setNetwork: filteredData[indexPath.row].network, setName: filteredData[indexPath.row].name)
        
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filteredData[indexPath.row].network)
        tableSCDelegate?.getTableValue(network: filteredData[indexPath.row].network)

    }
    
}

// MARK: UISearchBarDelegate
extension SupportedCurrencyTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        MARK: Filter
        filteredData = searchText.isEmpty ? dataJsonSC : dataJsonSC.filter ({
            $0.name.contains(searchText)
        })
        // Фильтрация плохо работает, нужно сделать .lowercased()
        // Во первых ищу по .name а не network
    }
    
}

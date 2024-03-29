//
//  SupportedCurrencyTableVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

protocol FirstDelegate: AnyObject {
    func getFirstTableValue(ticker: String)
}

protocol SecondDelegate: AnyObject {
    func getSecondTableValue(ticker: String)
}

class SupportedCurrencyTableVC: UITableViewController {
    
    
    
    weak var firstDelegate: FirstDelegate?
    weak var secondDelegate: SecondDelegate?
    
    
    
    var dataJsonSC: [JsonSupportedCurrencies] = []
        
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
        
        tableView.register(SupportedCurrencyTVCell.self, forCellReuseIdentifier: SupportedCurrencyTVCell.idExchangeTVCell)
        
        
        let manager = ExchangeManager()
        // Данные в таблице дублированны 
        manager.getSupportedCurrencies { jsonSC in
            DispatchQueue.main.async {
                self.dataJsonSC = jsonSC
                self.filteredData = self.dataJsonSC
//                self.filteredData = jsonSC
            }
        }
        tableView.dataSource = self
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Configure Nav View
    private func configureNavView() {
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
//        title = ""
        
        // MARK: Search Controller
        self.navigationItem.titleView = nil
        
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
    }
    
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return filteredData.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SupportedCurrencyTVCell.idExchangeTVCell, for: indexPath) as? SupportedCurrencyTVCell
        
        
        if
            let networkVal = filteredData[indexPath.row].ticker?.uppercased(),
            let nameVal = filteredData[indexPath.row].name
        {
            cell?.configure(setNetwork: networkVal, setName: nameVal)
        }
        
        
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard
            let networkVal = filteredData[indexPath.row].ticker
        else { return }
        
        print(networkVal)
        
        firstDelegate?.getFirstTableValue(ticker: networkVal)
        secondDelegate?.getSecondTableValue(ticker: networkVal)
        
        if searchController.isActive {
            searchController.dismiss(animated: true)
        }
        self.dismiss(animated: true)
   
    }
}

// MARK: Search Bar Delegate
extension SupportedCurrencyTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        MARK: Filter
//        filteredData = searchText.isEmpty ? dataJsonSC : dataJsonSC.filter ({
//            return $0.name.lowercased().contains(searchText.lowercased()) ||
//            $0.ticker.contains(searchText.lowercased())
//            // Вроде работает нормально
//        })
        
        filteredData = searchText.isEmpty ? dataJsonSC : dataJsonSC.filter({ value in
            if
                let one = value.name?.lowercased().contains(searchText.lowercased()),
                let two = value.ticker?.contains(searchText.lowercased())
            {
                return one || two
            }
            
            return false
        })
        
    }
}

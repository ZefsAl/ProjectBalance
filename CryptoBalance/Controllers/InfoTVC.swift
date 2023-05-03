//
//  InfoVC.swift
//  CryptoBalance
//
//  Created by Serj on 19.04.2023.
//

import UIKit

// MARK: Model
struct InfoSections {
    let title: String?
    let options: [InfoOptions]
}

struct InfoOptions {
    let title: String?
    let icon: UIImage?
    let iconBGC: UIColor?
    let handler: (() -> Void)
}


class InfoTVC: UITableViewController {
    

    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavView()
        
        
        
        // Delegate
        self.tableView.delegate = self
        
        // Style
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        
        
        // Register
        self.tableView.register(InfoTVCell.self, forCellReuseIdentifier: InfoTVCell().idInfoTVCell)
//        self.tableView.register(NEWTableViewCell.self, forCellReuseIdentifier: NEWTableViewCell().idNEWTableViewCell)
        
        
        
        
        configureArrData()
        
    }
    
    private func configureNavView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Info"
    }
    
    
    var infoArr: [InfoSections] = []
    
    private func configureArrData() {
        
        infoArr.append(InfoSections(title: "Contact", options: [
            InfoOptions.init(title: "cryptoact.dev@gmail.com", icon: UIImage(systemName: "envelope.fill"), iconBGC: .systemOrange, handler: {
                print("Options0 tapped")
            }),
            
        ]))
        
        infoArr.append(InfoSections(title: "Exchange support", options: [
            InfoOptions.init(title: "exchange-support@gmail.com", icon: UIImage(systemName: "envelope.fill"), iconBGC: .systemOrange, handler: {
                print("Options0 tapped")
            }),
            
            
        ]))
        
        infoArr.append(InfoSections(title: "", options: [
            InfoOptions.init(title: "Term of use", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {
                
            }),
            InfoOptions.init(title: "Private policy", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {
                
            }),
            
        ]))
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if let appVersion = appVersion {
            infoArr.append(InfoSections(title: "", options: [
                InfoOptions.init(title: "Version: \(appVersion)", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {
                    
                }),
            ]))
        }
        
        
        
    }
    
    

    
    // MARK: Table View Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        infoArr.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArr[section].options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTVCell().idInfoTVCell) as? InfoTVCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: NEWTableViewCell().idNEWTableViewCell) as? NEWTableViewCell
        
        let array = infoArr[indexPath.section].options[indexPath.row]
        cell?.configure(with: array)
        
        
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTVCell().idInfoTVCell) as? InfoTVCell

        return cell?.frame.height ?? 44
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let array = infoArr[indexPath.section].options[indexPath.row]
        array.handler()
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = .systemGray
        
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//            header.textLabel?.frame = header.bounds
//            header.textLabel?.textAlignment = .center
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return infoArr[section].title
    }
    
}

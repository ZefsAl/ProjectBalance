//
//  InfoVC.swift
//  CryptoBalance
//
//  Created by Serj on 19.04.2023.
//

import UIKit
import SafariServices

// MARK: Model
struct InfoSections {
    let title: String?
    let options: [InfoSectionsType]
}

enum InfoSectionsType {
    case optionsCell(model: InfoOptions)
    case regularCell(model: InfoRegularCell)
}

struct InfoOptions {
    let title: String?
    let icon: UIImage?
    let iconBGC: UIColor?
    let handler: (() -> Void)
}

struct InfoRegularCell {
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
        self.tableView.register(RegularInfoTVCell.self, forCellReuseIdentifier: RegularInfoTVCell().idRegularInfoTVCell)
        
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
            
            .optionsCell(model: InfoOptions(title: "cryptoact.dev@gmail.com", icon: UIImage(systemName: "envelope.fill"), iconBGC: .systemOrange, handler: {
                
                let mail = "cryptoact.dev@gmail.com"
                
                self.cellAction(title: "Contact", message: mail, copyAddress: mail, openMail: mail)
                
            })),
            
        ]))
//
        infoArr.append(InfoSections(title: "Exchange support", options: [
            .optionsCell(model: InfoOptions(title: "exchange-support@gmail.com", icon: UIImage(systemName: "envelope.fill"), iconBGC: .systemOrange, handler: {
                
                let mail = "exchange-support@gmail.com"
                
                self.cellAction(title: "Exchange support", message: mail, copyAddress: mail, openMail: mail)
                
            }))
            
        ]))
        
        infoArr.append(InfoSections(title: "", options: [
            
            .optionsCell(model: InfoOptions(title: "Term of use", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {

                guard let url = URL(string: "https://cryptoactterms.web.app") else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let safariVC = SFSafariViewController(url: url)
                    safariVC.modalPresentationStyle = .pageSheet
                    self.present(safariVC, animated: true)
                }
                
            })),
            
            .optionsCell(model: InfoOptions(title: "Private policy", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {

                guard let url = URL(string: "https://cryptoactprivacy.web.app") else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let safariVC = SFSafariViewController(url: url)
                    safariVC.modalPresentationStyle = .pageSheet
                    self.present(safariVC, animated: true)
                }
                
            }))

        ]))
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if let appVersion = appVersion {
            infoArr.append(InfoSections(title: "", options: [
                
                .regularCell(model: InfoRegularCell(title: "Version: \(appVersion)", icon: UIImage(systemName: "questionmark.circle.fill"), iconBGC: .systemGray, handler: {
                    ///
                }))
            ]))
        }
        
    }
    
    // MARK: Cell Action
    func cellAction(title: String, message: String?, copyAddress: String?, openMail: String?) {

        let cellAlert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        cellAlert.view.tintColor = .white
        
        
        cellAlert.addAction(UIAlertAction(title: "Copy address", style: .default, handler: { action in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showSmallCustomAnnotation(message: "Address copied", imageSystemName: "checkmark.circle", imageColor: .systemGreen)
                
                UIPasteboard.general.string = copyAddress
                generator.impactOccurred()
            }
            
        }))
        
        
        cellAlert.addAction(UIAlertAction(title: "Open mail", style: .default, handler: { action in
            
            guard let openMail = openMail else { return }
            if let url = URL(string: "mailto:\(openMail)") {
                UIApplication.shared.open(url)
            }
            
            
        }))
        
        
        
        cellAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            cellAlert.dismiss(animated: true)
        }))
        
        self.present(cellAlert, animated: true)
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
        let cellRegular = tableView.dequeueReusableCell(withIdentifier: RegularInfoTVCell().idRegularInfoTVCell) as? RegularInfoTVCell
        
        let array = infoArr[indexPath.section].options[indexPath.row]
        
        switch array.self {
        case .optionsCell(let model):
            cell?.configure(with: model)
            return cell ?? UITableViewCell()
        case .regularCell(let model):
            cellRegular?.configure(with: model)
            cellRegular?.selectionStyle = .none
            return cellRegular ?? UITableViewCell()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTVCell().idInfoTVCell) as? InfoTVCell

        return cell?.frame.height ?? 44
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let array = infoArr[indexPath.section].options[indexPath.row]
        
        switch array.self {
        case .optionsCell(let model):
            model.handler()
        case .regularCell(let model):
            model.handler()
        }
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

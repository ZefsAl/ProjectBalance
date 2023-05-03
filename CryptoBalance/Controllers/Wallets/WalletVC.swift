//
//  MainViewController.swift
//  CryptoBalance
//
//  Created by Serj on 31.12.2022.
//

import UIKit
import CoreData



class WalletVC: UIViewController {
    
    
    // MARK: CoreData Controller
    lazy var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WalletModel")
        let sortDescriptor = NSSortDescriptor(key: "dateSort", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }()
    
    
    

    
    // MARK: Refresh Control
    let refreshControl: UIRefreshControl = {
        
       let rc = UIRefreshControl()
//        rc.attributedTitle = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)])
                                                
        rc.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
        rc.addTarget(Any?.self, action: #selector(refresh), for: .valueChanged)
        return rc
    }()
    
    @objc private func refresh() {
        
//        runTimer()
        // Можно добавить таймер в левый нав бар ограничить релоад до 1  раза в 15 минут ?
        
        let semaphore = DispatchSemaphore(value: 3)
        let backgroundQueue = DispatchQueue(label: "Background queue")
        let storageQueue = DispatchQueue(label: "Serial queue")
        
        
        // Извлечение
        let fetchRequest = fetchResultController.fetchRequest
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            for val in result as! [WalletModel] {
                
                guard
                    let networkVal = val.network,
                    let addressVal = val.address
                else { return }
                
                backgroundQueue.async { [weak self] in
                    guard let self = self else { return }
                    
                    semaphore.wait()
                    
                    // Request
                    WalletManager().queryBalance(network: networkVal, address: addressVal) { jsonBM in
                        storageQueue.async {
                            val.balance = "\(SupportResources().convertSatoshi(jsonBM.balance))"
                            CoreDataManager.shared.saveContext()

                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                self.walletTableView.reloadData()
                            }
                        }
                    }
                    
                    // Test
//                    DispatchQueue.main.async {
//                        val.balance = "0.0"
//                        CoreDataManager.shared.saveContext()
//                        self.walletTableView.reloadData()
//                    }
                    
                    semaphore.signal()
                }
            }
            print(result.count)
        } catch {
            print("Error fethcing CD: \(error)")
        }
        // end
        
        
        self.refreshControl.endRefreshing()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
        
        
        
        
        
        
        
        
    
    // MARK: Wallet Table View
    let walletTableView = WalletTableView()
    
    // MARK: Wallet Scroll View
    let walletScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureNavView()
        setUpViews()
        setConstraints()
        
        // Delegate
        //        walletScrollView.walletTableView.delegate = self
        //        walletScrollView.walletTableView.dataSource = self
        walletTableView.delegate = self
        walletTableView.dataSource = self
        
        
        fetchResultController.delegate = self // in Extension
        
        
        
        // do - Так и будет в viewDidLoad ?
        do {
            //Выполнить выборку
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        
        
        // MARK: Извлечение TEST
        let fetchRequest = fetchResultController.fetchRequest
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            for val in result as! [WalletModel] {
                //                CoreDataManager.shared.context.delete(val)
                //                CoreDataManager.shared.saveContext()
                print("\(String(describing: val.network)), \(String(describing: val.balance)) ")
            }
            print(result.count)
        } catch {
            print("Error fethcing CD: \(error)")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.resignFirstResponder()
    }
    
    // MARK: Set up Views
    private func setUpViews() {
        view.addSubview(walletScrollView)
        walletScrollView.addSubview(refreshControl)
        walletScrollView.addSubview(walletTableView)
        
//        view.addSubview(refreshControl)
        
    }
    
    
    
}

extension WalletVC {
    // MARK: Configure Nav View
    private func configureNavView() {
//        view.backgroundColor = .systemPink
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Wallets"
        
        
        
        // MARK: Custom Add Button
        let addButtonView: UIView = {
            let lable = UILabel()
            lable.text = "Add "
            lable.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            let configImage = UIImage(systemName: "plus",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .regular))
            let image = UIImageView(image: configImage)
            image.tintColor = .white
            
            let stack = UIStackView(arrangedSubviews: [lable,image])
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        // UIBarButtonItem - not work решил через - UITapGestureRecognizer
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showModal))
        addButtonView.addGestureRecognizer(gesture)
        let barButtonItem = UIBarButtonItem(customView: addButtonView)
        navigationItem.rightBarButtonItem = barButtonItem
        
        // MARK: Edit Buttton
        //        let barEditButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
        //        barEditButton.tintColor = .white
        //        navigationItem.leftBarButtonItem = barEditButton
    }
    
    @objc func showModal() {
        let navController = UINavigationController(rootViewController: AddWalletVC())
        self.navigationController?.present(navController, animated: true)
    }
    
    // MARK: Cell Action
    func cellAction(title: String, message: String?, indexPath: IndexPath, copyAddress: String?, copyBalance: String? ) {
        
        
        
        let cellAlert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        cellAlert.view.tintColor = .white
        
        
        cellAlert.addAction(UIAlertAction(title: "Copy address", style: .default, handler: { action in
            UIPasteboard.general.string = copyAddress
            generator.impactOccurred()
        }))
        
        
        cellAlert.addAction(UIAlertAction(title: "Copy balance", style: .default, handler: { action in
            UIPasteboard.general.string = copyBalance
            
            generator.impactOccurred()
        }))
        
        
        cellAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            generator.impactOccurred()
            
            // MARK: DELETE CoreData Action
            guard let valObject = self.fetchResultController.object(at: indexPath) as? WalletModel else { return }
            CoreDataManager.shared.context.delete(valObject)
            CoreDataManager.shared.saveContext()
        }))
        
        
        
        cellAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            cellAlert.dismiss(animated: true)
        }))
        
        self.present(cellAlert, animated: true)
    }
    
}



// MARK: CoreData Delegate
extension WalletVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        walletTableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        walletTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                walletTableView.insertRows(at: [indexPath], with: .automatic)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                walletTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            break;
        case .update:
            if let _ = indexPath {
                //                guard let cell = mainTableView.cellForRow(at: indexPath) as? TableViewCell else { return }
                //                guard let valObject = fetchResultController.object(at: indexPath) as? WalletModel else { return }
                
                //                guard let valNetwork = valObject.network else { return }
                //                guard let valBalance = valObject.balance else { return }
                //                cell.configure(network: valNetwork, balance: String(valBalance))
                
            }
        default:
            break;
        }
    }
}





// MARK: Constraints
extension WalletVC {
    private func setConstraints() {
//                        let margin = view.layoutMarginsGuide
        let marginSV2 = walletScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            
            walletScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            walletScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            walletScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            walletScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            
            
            
            walletTableView.topAnchor.constraint(equalTo: marginSV2.topAnchor, constant: 24),
            walletTableView.leadingAnchor.constraint(equalTo: marginSV2.leadingAnchor, constant: 16),
            walletTableView.trailingAnchor.constraint(equalTo: marginSV2.trailingAnchor, constant: -16),
            walletTableView.bottomAnchor.constraint(equalTo: marginSV2.bottomAnchor, constant: -24),
            
            walletTableView.widthAnchor.constraint(equalTo: walletScrollView.widthAnchor, constant: -32),
            
            
            
        ])
    }
}


// MARK: UITableViewDelegate
extension WalletVC: UITableViewDelegate {}



// MARK: UITableViewDataSource
extension WalletVC: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchResultController.sections?.count ?? 0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WalletTVCell.idWalletTVCell, for: indexPath) as? WalletTVCell
        
        let valObject = fetchResultController.object(at: indexPath) as? WalletModel
        guard
            let valNetwork = valObject?.network,
            let valBalance = valObject?.balance
                //            let finalNTX = valObject?.finalNTX
        else { return UITableViewCell()}
        
        
        let resource = SupportResources()
        let lie = resource.lyingString(string: valNetwork)
        cell?.configure(network: lie, balance: String(valBalance), iconName: valNetwork)
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let valObject = fetchResultController.object(at: indexPath) as? WalletModel
        guard
            let valNetwork = valObject?.network,
            let valBalance = valObject?.balance,
            let valAddress = valObject?.address
        else { return }
        
        cellAction(title: "\(valNetwork.uppercased()) • \(valBalance)", message: valAddress, indexPath: indexPath, copyAddress: valAddress, copyBalance: valBalance)
        
    }
    
    
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            guard let valObject = fetchResultController.object(at: indexPath) as? WalletModel else { return }
    //            CoreDataManager.shared.context.delete(valObject)
    //            CoreDataManager.shared.saveContext()
    //        }
    //
    //    }
}

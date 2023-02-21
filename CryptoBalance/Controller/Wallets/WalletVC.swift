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
    
    
    
// MARK: Instances
    let mainTableView = MainTableView()

    
// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        setupViews()
        setConstraints()
        
        // Delegate
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
        fetchResultController.delegate = self // Extension
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
    
    
    private func setupViews() {
        view.addSubview(mainTableView)
    }
    
}

extension MainViewController {
    private func configureNavView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Wallets"
        
        // MARK: Custom Add Button
        let addButtonView: UIView = {
            let lable = UILabel()
            lable.text = "Add "
            let image = UIImageView(image: UIImage(systemName: "plus"))
            image.tintColor = .white
            
            let stack = UIStackView(arrangedSubviews: [lable,image])
            stack.addSubview(lable)
            stack.addSubview(image)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        // UIBarButtonItem - not work решил через - UITapGestureRecognizer
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showModal))
        addButtonView.addGestureRecognizer(gesture)
        let barButtonItem = UIBarButtonItem(customView: addButtonView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func showModal() {
        let navController = UINavigationController(rootViewController: AddWalletVC())
        self.navigationController?.present(navController, animated: true)
    }
}



// MARK: CoreData Delegate
extension WalletVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                mainTableView.insertRows(at: [indexPath], with: .automatic)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                mainTableView.deleteRows(at: [indexPath], with: .automatic)
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
        //        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


// MARK: UITableViewDelegate
extension WalletVC: UITableViewDelegate {
}



// MARK: UITableViewDataSource
extension WalletVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return walletArray.count
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idTableViewCell, for: indexPath) as? TableViewCell
        
        let valObject = fetchResultController.object(at: indexPath) as? WalletModel
        guard let valNetwork = valObject?.network else { return UITableViewCell()}
        guard let valBalance = valObject?.balance else { return UITableViewCell()}
        
        let resource = SupportResources()
        let lie = resource.lyingString(string: valNetwork)
//        cell?.configure(network: lie, balance: String(valBalance))
        cell?.configure(network: lie, balance: String(valBalance), iconName: valNetwork)
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let valObject = fetchResultController.object(at: indexPath) as? WalletModel else { return }
            CoreDataManager.shared.context.delete(valObject)
            CoreDataManager.shared.saveContext()
        }
        
    }
}

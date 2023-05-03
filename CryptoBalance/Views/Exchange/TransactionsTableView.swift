//
//  TransactionsTVC.swift
//  CryptoBalance
//
//  Created by Serj on 27.03.2023.
//

import UIKit
import CoreData

class TransactionsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: CoreData Controller
    lazy var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IdTtransactions")
        let sortDescriptor = NSSortDescriptor(key: "idTtransaction", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }()
    
    
    
    
    
    
    
    
    
    // MARK: Size
    // размер таблицы по контенту
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    
    
    
    let footerView = FooterView()
    
    
    // MARK: init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isScrollEnabled = false
        self.delegate = self
        self.dataSource = self
        self.register(TransactionsTVCell.self, forCellReuseIdentifier: TransactionsTVCell().idTransactionsTVCell)
        
        // Style
        self.layer.cornerRadius = 12
        
        // Delegate
        fetchResultController.delegate = self // in Extension
        
        
        // Выполнить выборку
        do {
            try fetchResultController.performFetch()
        } catch {
            print("Error performFetch - \(error)")
        }
        
        
        
        //         Test
        let fetchRequest = fetchResultController.fetchRequest
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            for val in result as! [IdTtransactions] {
                //                CoreDataManager.shared.context.delete(val)
                //                CoreDataManager.shared.saveContext()
            }
            print(result.count)
            print(result)
        } catch {
            print("Error fethcing CD: \(error)")
        }
        
    }
    
    
    
    
    // MARK: Transaction Array
    var transactionArray: [JsonTransactionStatus] = [] {
        didSet {
            
            // Exclude Duplicating
            transactionArray = transactionArray.uniqued()
            
            // по didSet обновляется массив с фильтрацией стал Optional
            transactionArray = transactionArray.sorted(by: { val1, val2 in
                if
                    let one = val1.transaction?.createdAt,
                    let two = val2.transaction?.createdAt {
                    return one > two
                } else {
                    print("error sorted transactionArray")
                    return false
                }
            })
            
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    
    // MARK: Request Get Transaction
    func requestGetTransaction() {
        
        
        // Запрос CoreDataManager
        let fetchRequest = fetchResultController.fetchRequest
        
        // Делаем запрос по каждому id
        do {
            let result = try CoreDataManager.shared.context.fetch(fetchRequest)
            for val in result as! [IdTtransactions] {
                
                guard let idTtransaction = val.idTtransaction else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    ExchangeManager().getTransactionStatus(id: idTtransaction) { JsonTS in
                        self.transactionArray.append(JsonTS)
                        print("requestGetTransaction + append")
                    }
                }
            }
            print(result.count)
            
            
        } catch {
            print("Error fethcing CD: \(error)")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if transactionArray.count != 0 {
            DispatchQueue.main.async {
                self.tableFooterView = UIView()
            }
        } else {
            DispatchQueue.main.async {
                self.tableFooterView = self.footerView
            }
        }
        
        return transactionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTVCell().idTransactionsTVCell) as? TransactionsTVCell
        
        
        guard
            let from = transactionArray[indexPath.row].transaction?.from?.uppercased(),
            let amountDeposit = transactionArray[indexPath.row].transaction?.amountDeposit,
            let to = transactionArray[indexPath.row].transaction?.to?.uppercased(),
            let amountEstimated = transactionArray[indexPath.row].transaction?.amountEstimated,
            let createdAt =  transactionArray[indexPath.row].transaction?.createdAt,
            let status = transactionArray[indexPath.row].transaction?.status
        else {
            return UITableViewCell()
        }
        
        
        let fromText: String = "\(from) • \(amountDeposit)"
        let toText: String = "\(to) • \(amountEstimated)"
        
        let date = SupportResources().getShortDateFormat(dateString: createdAt)
        
        cell?.configure(
            status: status,
            date: date,
            from: fromText,
            to: toText
        )
        
        
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
    // MARK: Cell Action
    func cellAction(title: String, message: String?, indexPath: IndexPath ) {
        
        let cellAlert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        
        cellAlert.view.tintColor = .white
        
//        cellAlert.addAction(UIAlertAction(title: "TEST", style: .default, handler: { action in
//            generator.impactOccurred()
//        }))
        
        
        cellAlert.addAction(UIAlertAction(title: "Details", style: .default, handler: { action in
            
            guard
            let detailArrData = self.transactionArray[indexPath.row].transaction
            else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                    
                // Config Data
                let transactionVC = TransactionVC()
                transactionVC.fromValue = detailArrData.from
                transactionVC.toValue = detailArrData.to
                transactionVC.payValue = detailArrData.amountDeposit
                transactionVC.payToAddressValue = detailArrData.addressDeposit
                transactionVC.statusValue = detailArrData.status
                transactionVC.createdDateValue = SupportResources().getShortDateFormat(dateString: detailArrData.createdAt ?? "")
                transactionVC.estimatedAmountValue = detailArrData.amountEstimated
                transactionVC.receivingAddressValue = detailArrData.addressReceive
                transactionVC.refundAdressValue = detailArrData.refundAddress
                transactionVC.idTransactionValue = detailArrData.id
                transactionVC.userUniqueValue = detailArrData.userUnique

                // Config View
                transactionVC.imageMain.isHidden = true
                transactionVC.view.backgroundColor = .systemGray6
                transactionVC.setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))

                
                let navTransactionVC = UINavigationController(rootViewController: transactionVC)
                self.window?.rootViewController?.present(navTransactionVC, animated: true, completion: nil)
            }
            
            
            generator.impactOccurred()
        }))
        
        
        // MARK: Delete from Core Data + Save
        cellAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            generator.impactOccurred()
            
            
            // First delete !!!
            guard let valObject = self.fetchResultController.object(at: indexPath) as? IdTtransactions else { return }
            
            CoreDataManager.shared.context.delete(valObject)
            CoreDataManager.shared.saveContext()
            print("Delete form Core Data")
            
            // Second delete !!!
            DispatchQueue.main.async {
                self.transactionArray.remove(at: indexPath.row)
                self.reloadData()
            }
            
            
        }))
        
        
        
        cellAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            cellAlert.dismiss(animated: true)
        }))
        
        // rootViewController present cellAction
        self.window?.rootViewController?.present(cellAlert, animated: true, completion: nil)
    }
    
    
    // MARK: Did Select Row At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let from = transactionArray[indexPath.row].transaction?.from?.uppercased(),
            let to = transactionArray[indexPath.row].transaction?.to?.uppercased(),
                let id = transactionArray[indexPath.row].transaction?.id
        else {
            return
        }
        
        let title = "\(from) • \(to)"
        
        let message = "ID: \(id)"
        
        cellAction(title: title, message: message, indexPath: indexPath)
    }
}


// MARK: Core Data Delegate
extension TransactionsTableView: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        // Update table
        if type == .insert {
            if let idTtransactionsVal = anObject as? IdTtransactions {
                if idTtransactionsVal.hasChanges {
                    print("REQUEST is UPDATE ")
                    requestGetTransaction()
                }
            }
        }
    }
    
}

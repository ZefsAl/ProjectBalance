//
//  ReceiveVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.03.2023.
//

import UIKit

class ReceiveVC: UIViewController {
    
    
    let receiveScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceVertical = true
        sv.isScrollEnabled = false
        return sv
    }()
    
    
    // MARK: Exchange Data
    var fromTicker: String?
    var toTicker: String?
    var amountFrom: String?
    var amountTo: String?
    var quotaID: String?
    
    // MARK: Reminder Lable Config
    func reminderLableConfig() {
        if
            let fromTicker = fromTicker,
            let toTicker = toTicker,
            let amountFrom = amountFrom,
            let amountTo = amountTo
        {
            reminderFromLable.text = "\(fromTicker.uppercased()) • \(amountFrom)"
            reminderToLable.text = "\(toTicker.uppercased()) • \(amountTo)"
            
            receiveTF.placeholder? += " • \(toTicker.uppercased())"
            refundAddressTF.placeholder? += " • \(fromTicker.uppercased())"
        }
        else {
            print("Error read reminder value")
        }
    }
    
    
    // MARK: Confirm Button
    let confirmButton: Button_Loader = {
        let bl = Button_Loader()
//        bl.isHidden = true
        bl.alpha = 0
        bl.addTarget(Any?.self, action: #selector(сonfirmBtnAction), for: .touchUpInside)
        return bl
    }()
    
    // MARK: Request POST Create Transaction
    @objc func сonfirmBtnAction() {
        print("сonfirmBtnAction pressed ")
        
        // Button
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.confirmButton.lable.isHidden = true
            self.confirmButton.activityIndicator.startAnimating()
            self.confirmButton.isUserInteractionEnabled = false
        }
        
        // Data для запроса
        guard
            let fromTicker = fromTicker,
            let toTicker = toTicker,
            let amountFrom = amountFrom,
            let quotaID = quotaID,
            let addressReceive = receiveTF.text,
            let refundAddress = refundAddressTF.text
        else { return }
        
        // Request
        ExchangeManager().postCreateTransaction(
            fromTiker: fromTicker,
            toTicker: toTicker,
            amountDeposit: amountFrom,
            addressReceive: addressReceive,
            refundAddress: refundAddress,
            refundExtraId: destinationTagTF.text ?? "",
            quotaId: quotaID
        ) { jsonT in
            

            
            
            // Разные ошибки
            // Так же есть статускод 400 но Error true
            // Пока что так
            if jsonT.error != nil {
                DispatchQueue.main.async {
                    self.showRegularCustomAnnotation(message: "Failed to create an order. Please, try later.", imageSystemName: "exclamationmark.triangle", imageColor: .systemOrange)
                }
                
                // Default BTN State
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.confirmButton.lable.isHidden = false
                    self.confirmButton.activityIndicator.stopAnimating()
                    self.confirmButton.isUserInteractionEnabled = true
                }
            }
            
                // Не открывать transactionVC
            guard jsonT.transaction != nil else { return }
            
            DispatchQueue.main.async {
                
                // Config view
                let transactionVC = TransactionVC()
                
                transactionVC.fromValue = jsonT.transaction?.from
                transactionVC.toValue = jsonT.transaction?.to
                transactionVC.payValue = jsonT.transaction?.amountDeposit
                transactionVC.payToAddressValue = jsonT.transaction?.addressDeposit
                transactionVC.statusValue = jsonT.transaction?.status
                transactionVC.createdDateValue = SupportResources().getShortDateFormat(dateString: jsonT.transaction?.createdAt ?? "")
                transactionVC.estimatedAmountValue = jsonT.transaction?.amountEstimated
                transactionVC.receivingAddressValue = jsonT.transaction?.addressReceive
                transactionVC.refundAdressValue = jsonT.transaction?.refundAddress
                transactionVC.idTransactionValue = jsonT.transaction?.id
                transactionVC.userUniqueValue = jsonT.transaction?.userUnique
                
                // Config + Push view
                transactionVC.setDismissNavButtonItem(selectorStr: Selector(("popToRootButtonAction")))
                transactionVC.hidesBottomBarWhenPushed = true
                transactionVC.navigationItem.setHidesBackButton(true, animated: true)
                self.navigationController?.pushViewController(transactionVC, animated: true)
                
                // Core Data
                guard let idVal = jsonT.transaction?.id else { return }
                let IdTtransactions = IdTtransactions()
                IdTtransactions.idTtransaction = idVal
                CoreDataManager.shared.saveContext()
            }
        }
    }
    
    
    
    // MARK: Reminder Item
    let reminderFromLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = " • "
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    let reminderToLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = " • "
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    let reminderDivider: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        v.layer.cornerRadius = 1
        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return v
    }()
    
    // MARK: Receive Item
    let receiveLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Receive to wallet"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        
        return l
    }()
    let receiveImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        // No config
        
        iv.widthAnchor.constraint(equalToConstant: 17).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        return iv
    }()
    let receiveTF = RegularTextField(frame: .null, setPlaceholder: "Address") // Receive to the address
    
    
    
    // MARK: Receive Item
    let destinationTagLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Destination tag for refund address"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    let destinationTagTF = RegularTextField(frame: .null, setPlaceholder: "Memo tag (optional)")
    
    
    
    // MARK: Refund wallet Item
    let refundWalletLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Refund wallet"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    let refundImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        
        iv.widthAnchor.constraint(equalToConstant: 17).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        return iv
    }()
    let refundAddressTF = RegularTextField(frame: .null, setPlaceholder: "Address") // Refund to the address
    
    
    // MARK: Exchange card
    let formCardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 12
        return v
    }()
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // Reminder Info Stack
        let reminderInfoStack = UIStackView(arrangedSubviews: [reminderFromLable,reminderToLable,reminderDivider])
        reminderInfoStack.alignment = .fill
        reminderInfoStack.axis = .vertical
        reminderInfoStack.spacing = 8
        
        // Receive Header Stack
        let receiveHeaderStack = UIStackView(arrangedSubviews: [receiveLable, receiveImage])
        receiveHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        receiveHeaderStack.axis = .horizontal
        //        receiveHeaderStack.alignment = .fill
        receiveHeaderStack.distribution = .fill
        
        // Receive Item Stack
        let receiveItemStack = UIStackView(arrangedSubviews: [receiveHeaderStack, receiveTF])
        receiveItemStack.translatesAutoresizingMaskIntoConstraints = false
        receiveItemStack.axis = .vertical
        receiveItemStack.alignment = .fill
        receiveItemStack.spacing = 4
        
        // Destination Item Stack
        let destinationItemStack = UIStackView(arrangedSubviews: [destinationTagLable, destinationTagTF])
        destinationItemStack.translatesAutoresizingMaskIntoConstraints = false
        destinationItemStack.axis = .vertical
        destinationItemStack.alignment = .fill
        destinationItemStack.spacing = 4
        
        // Refund Header Stack
        let refundHeaderStack = UIStackView(arrangedSubviews: [refundWalletLable, refundImage])
        refundHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        refundHeaderStack.axis = .horizontal
        refundHeaderStack.distribution = .fill
        
        // Refund Wallet Item Stack
        let refundWalletItemStack = UIStackView(arrangedSubviews: [refundHeaderStack, refundAddressTF])
        refundWalletItemStack.translatesAutoresizingMaskIntoConstraints = false
        refundWalletItemStack.axis = .vertical
        refundWalletItemStack.alignment = .fill
        refundWalletItemStack.spacing = 4
        
        
        // Fields Stack
        let fieldsStack = UIStackView(arrangedSubviews: [reminderInfoStack,receiveItemStack,refundWalletItemStack, destinationItemStack])
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.axis = .vertical
        fieldsStack.alignment = .fill
        fieldsStack.spacing = 16
        
        
        // Set up Views
        formCardView.addSubview(fieldsStack)
        
        receiveScrollView.addSubview(formCardView)
        
        let margin = receiveScrollView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            
            formCardView.topAnchor.constraint(equalTo: receiveScrollView.topAnchor, constant: 24),
            formCardView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 8),
            formCardView.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -8),
            
            fieldsStack.topAnchor.constraint(equalTo: formCardView.topAnchor, constant: 20),
            fieldsStack.leadingAnchor.constraint(equalTo: formCardView.leadingAnchor, constant: 16),
            fieldsStack.trailingAnchor.constraint(equalTo: formCardView.trailingAnchor, constant: -16),
            fieldsStack.bottomAnchor.constraint(equalTo: formCardView.bottomAnchor, constant: -20),
        ])
        
    }
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view
        configureNavView()
        setUpStack()
        setUpViews()
        setConstraints()
        reminderLableConfig()
        
        
        // MARK: NotificationCenter keyboard
        // Show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Target
        receiveTF.addTarget(Any?.self, action: #selector(validationReceive), for: .editingDidEnd)
        refundAddressTF.addTarget(Any?.self, action: #selector(validationRefund), for: .editingDidEnd)
        
    }
    
    
    
    // MARK: Receive Is Valid
    var receiveIsValid = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.validationConfirmButton()
            }
        }
    }
    // MARK: Refund Is Valid
    var refundIsValid = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.validationConfirmButton()
            }
        }
    }
    
    // MARK: Receive validation + request
    @objc func validationReceive() {
        
        guard let toTickerVal = toTicker else { return }
        guard let receiveTFVal = receiveTF.text else { return }
        
        guard receiveTF.text != "" else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.receiveImage.tintColor = .clear
                self.receiveIsValid = false
            }
            return
        }
        
        ExchangeManager().validateAddress(ticker: toTickerVal, address: receiveTFVal) { jsonVA in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if jsonVA.result == true {
                    self.receiveImage.image = UIImage(systemName: "checkmark")
                    self.receiveImage.tintColor = .systemGreen
                    self.receiveIsValid = true
                } else if jsonVA.result == false {
                    self.receiveImage.image = UIImage(systemName: "exclamationmark")
                    self.receiveImage.tintColor = .systemRed
                    self.receiveIsValid = false
                } else {
                    DispatchQueue.main.async {
                        self.receiveImage.tintColor = .clear
                        self.receiveIsValid = false
                    }
                }
            }
        }
    }
    
    
    // MARK: Refund Validation + Request
    @objc func validationRefund() {
        
        guard let fromTickerVal = fromTicker else { return }
        guard let refundAddressTFVal = refundAddressTF.text else { return }
        
        guard refundAddressTF.text != "" else {
            DispatchQueue.main.async {
                self.refundImage.tintColor = .clear
                self.refundIsValid = false
            }
            return
        }
        
        ExchangeManager().validateAddress(ticker: fromTickerVal, address: refundAddressTFVal) { jsonVA in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if jsonVA.result == true {
                    self.refundImage.image = UIImage(systemName: "checkmark")
                    self.refundImage.tintColor = .systemGreen
                    self.refundIsValid = true
                } else if jsonVA.result == false {
                    self.refundImage.image = UIImage(systemName: "exclamationmark")
                    self.refundImage.tintColor = .systemRed
                    self.refundIsValid = false
                } else {
                    DispatchQueue.main.async {
                        self.refundImage.tintColor = .clear
                        self.refundIsValid = false
                    }
                }
            }
        }
    }
    
    @objc func validationConfirmButton() {
        
        if receiveIsValid == true &&
            refundIsValid == true
        {
            buttonIsValid(button: confirmButton, bool: true)
        } else {
            buttonIsValid(button: confirmButton, bool: false)
            return
        }
    }
    
    
    
    // MARK: Show, NSNotification
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Setting Permissions !!!
        receiveScrollView.isScrollEnabled = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Move
        let moveToTop = CGAffineTransform(translationX: 0.0, y: -(keyboardSize.height / 26))
        formCardView.transform = moveToTop
    }
    
    // MARK: Hide, NSNotification
    @objc func keyboardWillHide(notification: NSNotification) {
        
        // Setting Permissions !!!
        receiveScrollView.isScrollEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.isNavigationBarHidden = false
        
        // Move
        formCardView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
    }
    
    
    // MARK: Configure Nav View
    private func configureNavView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        // 1 из 50 Back button color появляется системный синий цвет кнопки
        title = "Receiving"
    }
    
    // MARK: Set up Views
    private func setUpViews() {
        view.addSubview(receiveScrollView)
        view.addSubview(confirmButton)
    }
    
    
}

// MARK: Constraints
extension ReceiveVC {
    private func setConstraints() {
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            receiveScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            receiveScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            receiveScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            receiveScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            confirmButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -24),
            confirmButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}



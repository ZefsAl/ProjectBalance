//
//  ExchangeVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

class ExchangeVC: UIViewController, FirstDelegate, SecondDelegate {
    
    // MARK: Scroll View Tracking
    private var lastVelocityYSign = 0
    
    // MARK: Refresh Control
    let refreshControl: UIRefreshControl = {
       let rc = UIRefreshControl()
//        rc.attributedTitle = NSAttributedString(string: "Refresh", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)])
        rc.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
        rc.addTarget(Any?.self, action: #selector(refresh), for: .valueChanged)
        
        return rc
    }()
    
    // MARK: Refresh Control + Request
    @objc func refresh() {
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Можно обьеденить с запросом
                self.transactionsTableView.transactionArray.removeAll()
                self.transactionsTableView.requestGetTransaction()
                self.transactionsTableView.reloadData()

                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
        }
    }
    
    
    // MARK: Exchange Scroll View
    let exchangeScrollView: UIScrollView = {
        var sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    
    
    
    // MARK: Delegate FirstDelegate, SecondDelegate
    // Жудкий костыль для разных кнопок
    func getFirstTableValue(ticker: String) {
        fromCurrencyButton.lable.text = ticker.uppercased()
        validation_From_To_BTNS()
    }
    
    func getSecondTableValue(ticker: String) {
        toCurrencyButton.lable.text = ticker.uppercased()
        validation_From_To_BTNS()
    }
    
    // MARK: Validation Button + Requests
    func validation_From_To_BTNS() {
        
        // Запрос при выборе валюты
        if fromCurrencyButton.lable.text != "" &&
            fromCurrencyButton.lable.text != "Select" &&
            toCurrencyButton.lable.text != "" &&
            toCurrencyButton.lable.text != "Select"
        {
            getLimitsRequest(){_ in }
        }
        
        
        //  Запросить при смене валюты
        if sendAmountTextField.text != "0.00000" &&
            sendAmountTextField.text != "" &&
            sendAmountTextField.text != "0" &&
            sendAmountTextField.text != "0.0" &&
            fromCurrencyButton.lable.text != "" &&
            fromCurrencyButton.lable.text != "Select" &&
            toCurrencyButton.lable.text != "" &&
            toCurrencyButton.lable.text != "Select"
        {
            getRateRequest()
        }
        
    }
    
    // MARK: Get Limits Request
    func getLimitsRequest(completion: @escaping (JsonGetLimits) -> Void) {
        guard
            let fromVal = fromCurrencyButton.lable.text?.lowercased(),
            let toVal = toCurrencyButton.lable.text?.lowercased()
        else {
            print( "Error guard for getLimits")
            return
        }
        
        
        
        DispatchQueue.main.async {
            ExchangeManager().getLimits(fromTicker: fromVal, toTicker: toVal) { jsonGL in
                
                completion(jsonGL)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let minAmountVal = jsonGL.minAmount else { return }
                    let minAmount = SupportResources().customDoubleToString(double: minAmountVal)
                    self.sendAnnotationLable.text = "Minimum: \(minAmount)"
                }
            }
        }
    }
    
    
    // MARK: Validation, Action, Request
    @objc func sendTextFieldAction() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.fromCurrencyButton.lable.text != "" &&
                self.fromCurrencyButton.lable.text != "Select" &&
                self.toCurrencyButton.lable.text != "" &&
                self.toCurrencyButton.lable.text != "Select" &&
                self.sendAmountTextField.text != ""
            {
                self.getRateRequest()
                self.getLimitsRequest { _ in }
            } else {
                if self.sendAmountTextField.text != "" {
                    self.showRegularCustomAnnotation(message: "Select Currency", imageSystemName: "exclamationmark.triangle", imageColor: .systemOrange)
                }
                self.getAmountLable.text = "0.00000"
                self.gettingNetwork.text = ""
                self.getAdapterTime.text = ""
                
                self.buttonIsValid(button: self.nextButton, bool: false)
            }
        }
    }
    
    
    // MARK: Next Button
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        b.backgroundColor = UIColor(named: "PrimaryColor")
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .black
        l.text = "Next"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(nextBtnAction), for: .touchUpInside)
        
//        b.isHidden = true
        b.alpha = 0
        return b
    }()
    
    // pass data
    var requestDataGetRate: [String: String] = [:]
    
    // MARK: Next Btn Action
    @objc func nextBtnAction() {
        let receiveVC = ReceiveVC()
        self.navigationController?.pushViewController(receiveVC, animated: true)
        
        // MARK: Configure data to receiveVC
        guard
            let fromTicker = requestDataGetRate["fromTicker"],
            let toTicker = requestDataGetRate["toTicker"],
            let amountFrom = requestDataGetRate["amountFrom"],
            let amountTo = requestDataGetRate["amountTo"],
            let quotaID = requestDataGetRate["quotaID"]
        else {
            print("Error configure data")
            return
        }
        
        receiveVC.fromTicker = fromTicker
        receiveVC.toTicker = toTicker
        receiveVC.amountFrom = amountFrom
        receiveVC.amountTo = amountTo
        receiveVC.quotaID = quotaID
        
    }
    
    
    // MARK: Request getRate
    @objc func getRateRequest() {
        
        // Animation
        DispatchQueue.main.async {
            self.loaderView.startAnimating();
        }
        
        // get ticker, value
        guard
            let fromVal = fromCurrencyButton.lable.text?.lowercased(),
            let toVal = toCurrencyButton.lable.text?.lowercased(),
            let amountVal = sendAmountTextField.text
        else {
            print( "Error guard getRate ")
            return
        }
        
        // MARK: Get Rate
        let nm = ExchangeManager()
        nm.getRate(from: fromVal, to: toVal, amountFrom: amountVal) { jsonGR in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                // Error
                if jsonGR.error == true {
                    
                    // Show Alert
                    self.getLimitsRequest() { jsonGL in
                        guard let minAmountVal = jsonGL.minAmount else { return }
                        guard let maxAmountVal = jsonGL.maxAmount else { return }
                        
                        let minAmount = SupportResources().customDoubleToString(double: minAmountVal)
                        let maxAmount = SupportResources().customDoubleToString(double: maxAmountVal)
                        
                        let message = "Try: Minimum: \(minAmount) \nMaximum: \(maxAmount)"
                        
                        DispatchQueue.main.async {
                            self.showRegularCustomAnnotation(message: message, imageSystemName: "exclamationmark.triangle", imageColor: .systemOrange)
                        }
                        
                    }
                    
                    // clear
                    self.getAmountLable.text = "Not available"
                    self.gettingNetwork.text = ""
                    self.getAdapterTime.text = ""
                    self.loaderView.stopAnimating();
                    
                    // Hide Button
                    self.buttonIsValid(button: self.nextButton, bool: false)
                    
                    
                } else {
                    
                    // + Validation Next Button
                    if let amountToVal = jsonGR.amountTo {
                        print(SupportResources().customDoubleToString(double: amountToVal))
                        
                        self.getAmountLable.text = SupportResources().customDoubleToString(double: amountToVal)
                        self.loaderView.stopAnimating();

                        self.buttonIsValid(button: self.nextButton, bool: true)
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            let moveToOriginal = CGAffineTransform(translationX: 0.0, y: 0.0)
                            self.nextButton.transform = moveToOriginal
                        } completion: { _ in }
                        
                    } else {

                        self.buttonIsValid(button: self.nextButton, bool: false)
                    }
                    
                    
                    guard let toTicker = jsonGR.to else { return }
                    self.gettingNetwork.text = " • \(toTicker.uppercased())"
                    
                    if let adapter = jsonGR.adapter, let timeAdapter = jsonGR.time {
                        self.getAdapterTime.text = "\(adapter) ~ \(timeAdapter)min"
                    }
                    
                }
                
                // MARK: Pass to receiveVC
                guard
                    let fromTicker = jsonGR.from,
                    let toTicker = jsonGR.to,
                    let amountFrom = jsonGR.amountFrom,
                    let amountTo = jsonGR.amountTo,
                    let quotaID = jsonGR.quotaID
                else {
                    print("Error pass notification data ")
                    return
                }
                
                let sr = SupportResources()
                self.requestDataGetRate = [
                    "fromTicker": fromTicker,
                    "toTicker" : toTicker,
                    "amountFrom" : sr.customDoubleToString(double: amountFrom),
                    "amountTo" : sr.customDoubleToString(double: amountTo),
                    "quotaID" : quotaID
                ]
            }
        }
    }
    
    
    
    
    // MARK: Transactions Table View Item
    let transactionsLable: CustomPaddingLabel = {
        let l = CustomPaddingLabel(top: 0, bottom: 0, left: 16, right: 0)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Status transactions"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        l.textColor = .systemGray
        return l
    }()
    let transactionsTableView = TransactionsTableView()
    
    // MARK: From Item Stack
    let fromLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "From"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    let fromCurrencyButton: CurrencyButtonV2 = {
        let b = CurrencyButtonV2()
        b.addTarget(Any.self, action: #selector(fromBtnAction), for: .touchUpInside)
        return b
    }()
    
    
    // MARK: To Item Stack
    let toCurrencyButton: CurrencyButtonV2 = {
        let b = CurrencyButtonV2()
        b.addTarget(Any.self, action: #selector(toBtnAction), for: .touchUpInside)
        return b
    }()
    
    let toLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "To"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    
    // MARK: Send Item Stack
    let sendLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Send"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    let sendAnnotationLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    var sendAmountTextField = AmountTextField()
    
    
    // MARK: Get Item Stack
    let getLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "You'll get"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    let gettingNetwork: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "" // • DOGE
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    let getAdapterTime: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = ""
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    let loaderView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        aiv.style = UIActivityIndicatorView.Style.medium
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    let getAmountLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "0.00000"
        l.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .white
        l.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return l
    }()
    
    let getDivider: UIView = {
        let v = UIView()
        //        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray5
        v.layer.cornerRadius = 1
        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return v
    }()
    
    // MARK: Exchange card
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 12
        return v
    }()
    
    let exchangeScrollViewStack = UIStackView()
    // MARK: Set up Stack
    func setUpStack() {
        
        // From
        let fromItemStack = UIStackView()
        fromItemStack.translatesAutoresizingMaskIntoConstraints = false
        fromItemStack.spacing = 4
        fromItemStack.axis = .vertical
        fromItemStack.alignment = .fill
        fromItemStack.addArrangedSubview(fromLable)
        fromItemStack.addArrangedSubview(fromCurrencyButton)
        
        // To
        let toItemStack = UIStackView()
        fromItemStack.translatesAutoresizingMaskIntoConstraints = false
        toItemStack.spacing = 4
        toItemStack.axis = .vertical
        toItemStack.alignment = .fill
        toItemStack.addArrangedSubview(toLable)
        toItemStack.addArrangedSubview(toCurrencyButton)
        
        // First Stack
        let firstStack = UIStackView(arrangedSubviews: [fromItemStack, toItemStack])
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.spacing = 16
        firstStack.axis = .horizontal
        firstStack.alignment = .center
        firstStack.distribution = .fillEqually
        
        
        // Send Lable Stack
        let sendLableStack = UIStackView(arrangedSubviews: [sendLable, UIView(), sendAnnotationLable])
        sendLableStack.alignment = .fill
        sendLableStack.axis = .horizontal
        sendLableStack.spacing = 4
        
        
        // Send Item Stack
        let sendItemStack = UIStackView(arrangedSubviews: [sendLableStack,sendAmountTextField])
        sendItemStack.alignment = .fill
        sendItemStack.axis = .vertical
        sendItemStack.spacing = 4
        
        // Getting Lable Stack
        let gettingLableStack = UIStackView(arrangedSubviews: [getLable,gettingNetwork, UIView(), getAdapterTime])
        gettingLableStack.alignment = .leading
        gettingLableStack.axis = .horizontal
        gettingLableStack.spacing = 0
        
        // loader Lable Stack
        let getLoaderStack = UIStackView(arrangedSubviews: [getAmountLable,loaderView])
        getLoaderStack.alignment = .fill
        getLoaderStack.axis = .horizontal
        getLoaderStack.spacing = 4
        
        // Get Item Stack  loaderView getAmountLable
        let getItemStack = UIStackView(arrangedSubviews: [gettingLableStack,getLoaderStack,getDivider])
        getItemStack.alignment = .fill
        getItemStack.axis = .vertical
        getItemStack.spacing = 4
        
        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [firstStack,sendItemStack,getItemStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.spacing = 16
        
        // Background card
        cardView.addSubview(mainStack)
        
        // Transactions Item Stack
        let transactionsItemStack = UIStackView(arrangedSubviews: [transactionsLable,transactionsTableView])
        transactionsItemStack.translatesAutoresizingMaskIntoConstraints = false
        transactionsItemStack.alignment = .fill
        transactionsItemStack.axis = .vertical
        transactionsItemStack.spacing = 8
        
        
        // Scroll View Stack
//        let exchangeScrollViewStack = UIStackView(arrangedSubviews: [cardView, transactionsItemStack])
        exchangeScrollViewStack.addArrangedSubview(cardView)
        exchangeScrollViewStack.addArrangedSubview(transactionsItemStack)
        exchangeScrollViewStack.translatesAutoresizingMaskIntoConstraints = false
        exchangeScrollViewStack.alignment = .fill
        exchangeScrollViewStack.axis = .vertical
        exchangeScrollViewStack.spacing = 24
        
        // Add Subview
        exchangeScrollView.addSubview(refreshControl)
        exchangeScrollView.addSubview(exchangeScrollViewStack)
        
        
        
        // MARK: Stack Constraints
//        let margin = view.layoutMarginsGuide
//        let marginSV = exchangeScrollView.layoutMarginsGuide
        let marginSV2 = exchangeScrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            
            exchangeScrollViewStack.topAnchor.constraint(equalTo: marginSV2.topAnchor, constant: 24),
            exchangeScrollViewStack.leadingAnchor.constraint(equalTo: marginSV2.leadingAnchor, constant: 16),
            exchangeScrollViewStack.trailingAnchor.constraint(equalTo: marginSV2.trailingAnchor, constant: -16),
            exchangeScrollViewStack.bottomAnchor.constraint(equalTo: marginSV2.bottomAnchor, constant: -24),
            
//            exchangeScrollViewStack.centerXAnchor.constraint(equalTo: exchangeScrollView.centerXAnchor),
            exchangeScrollViewStack.widthAnchor.constraint(equalTo: exchangeScrollView.widthAnchor, constant: -32),
        ])
    }
    
    // MARK: First BTN Action
    let firstTVC = SupportedCurrencyTableVC()
    @objc func fromBtnAction() {
        print("fromBtnAction press")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.sendAmountTextField.endEditing(true)
            if self.presentedViewController == nil {
                let modalNav = UINavigationController(rootViewController: self.firstTVC)
                self.firstTVC.title = "From currency"
                self.navigationController?.show(modalNav, sender: AnyObject.self)
            }
        }
    }
    
    // MARK: Second BTN Action
    let secondTVC = SupportedCurrencyTableVC()
    @objc func toBtnAction() {
        print("toBtnAction press")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.sendAmountTextField.endEditing(true)
            if self.presentedViewController == nil {
                let modalNav = UINavigationController(rootViewController: self.secondTVC)
                self.secondTVC.title = "To currency"
                self.navigationController?.show(modalNav, sender: AnyObject.self)
            }
        }
    }
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        setUpStack()
        setUpViews()
        
        setConstraints()
        
        // delegate
        firstTVC.firstDelegate = self
        secondTVC.secondDelegate = self
        exchangeScrollView.delegate = self
        
        
        // MARK: Target TextField
        sendAmountTextField.addTarget(Any?.self, action: #selector(sendTextFieldAction), for: .editingDidEnd)
        
        refresh()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    // MARK: Configure Nav View
    private func configureNavView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Exchange"
    }
    
    // MARK: Set up Views
    private func setUpViews() {
        view.addSubview(exchangeScrollView)
        view.addSubview(nextButton)
    }
    
}

// MARK: extension Constraints
extension ExchangeVC {
    private func setConstraints() {
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            exchangeScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            exchangeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exchangeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exchangeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}




// MARK: UIScrollViewDelegate
extension ExchangeVC: UIScrollViewDelegate {
    
    // MARK: Hide + Show Next Button
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentVelocityY = scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if currentVelocityYSign != lastVelocityYSign && currentVelocityYSign != 0 {
            lastVelocityYSign = currentVelocityYSign
        }
        if lastVelocityYSign < 0 {
//            print("SCROLLING DOWN")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(100.0))
                    self.nextButton.transform = moveToBottom
                } completion: { _ in }
            }
        } else if lastVelocityYSign > 0 {
//            print("SCOLLING UP")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    let moveToOriginal = CGAffineTransform(translationX: 0.0, y: 0.0)
                    self.nextButton.transform = moveToOriginal
                } completion: { _ in }
            }
        }
    }
    
    
}

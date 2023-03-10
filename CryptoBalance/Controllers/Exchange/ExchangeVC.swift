//
//  ExchangeVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

class ExchangeVC: UIViewController, FirstDelegate, SecondDelegate {
    
    // MARK: Delegate FirstDelegate, SecondDelegate
    // Жудкий костыль для разных кнопок
    func getFirstTableValue(ticker: String) {
        fromCurrencyButton.lable.text = ticker.uppercased()
        validationButton()
    }
    
    func getSecondTableValue(ticker: String) {
        toCurrencyButton.lable.text = ticker.uppercased()
        validationButton()
    }
    
    // MARK: Validation Button
    func validationButton() {
        if sendAmountTextField.text != "0.00000" &&
            sendAmountTextField.text != "" &&
            sendAmountTextField.text != "0" &&
            sendAmountTextField.text != "0.0"
        {
            print("getRateRequest")
            getRateRequest()
        }
        
    }
    
    
    
    
    // MARK: Validation, Action
    @objc func sendTextFieldAction() {

        
        // Delay for .editingChanged !!! // Отключил DispatchWallTime.now() + 1.0
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.fromCurrencyButton.lable.text != "" &&
                self.fromCurrencyButton.lable.text != "Select" &&
                self.toCurrencyButton.lable.text != "" &&
                self.sendAmountTextField.text != "" &&
                self.toCurrencyButton.lable.text != "Select"
            {
                self.getRateRequest()
            } else {
                if self.sendAmountTextField.text != "" {
                    self.showCustomAlert(message: "Select Currency")
                }
                self.getAmountLable.text = "0.00000"
                self.gettingNetwork.text = ""
                self.getAdapterTime.text = ""
            }
        }
        
    }
    
    
    
    // MARK: testButton
    let nextButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        b.backgroundColor = UIColor(named: "PrimaryColor")

//        b.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        b.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = false
        l.textColor = .black
        l.text = "Next"
        l.font = UIFont.systemFont(ofSize: 17, weight: .bold)

        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true

        b.addTarget(Any?.self, action: #selector(testAction), for: .touchUpInside)
        return b
    }()
    @objc func testAction() {
        showCustomAlert(message: "TestTestTestTestTestTestTestTest")
    }

    
    // MARK: Request getRate 
    @objc func getRateRequest() {
        print("Test request get rate")
        
        DispatchQueue.main.async {
            self.loaderView.startAnimating();
        }
    
        
        guard let fromVal = fromCurrencyButton.lable.text?.lowercased() else { return }
        guard let toVal = toCurrencyButton.lable.text?.lowercased() else { return }
        guard let amountVal = sendAmountTextField.text else { return }
        
        
        print(amountVal)
        let nm = ExchangeManager()
        
        nm.getRate(from: fromVal, to: toVal, amountFrom: amountVal) { jsonGR in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                
                
                if jsonGR.error == true {
                    
                    guard let message = jsonGR.message else { return }
                    self.showCustomAlert(message: message)
                    self.getAmountLable.text = "Not available"
                    self.gettingNetwork.text = ""
                    self.getAdapterTime.text = ""
                    self.loaderView.stopAnimating();
                    
                } else {

                    
//                    guard let amountToVal = jsonGR.amountTo else { return }
//                    self.getAmountLable.text = String(amountToVal)
                    if let amountToVal = jsonGR.amountTo {
                        self.getAmountLable.text = String(amountToVal)
                        self.loaderView.stopAnimating();
                        print(String(amountToVal))
                        
                    }
                    
                    guard let toTicker = jsonGR.to else { return }
//                    self.getLable.text = self.getLable.text! + " • \(toNetwork)"
                    self.gettingNetwork.text = " • \(toTicker.uppercased())"
                    
                    if let adapter = jsonGR.adapter, let timeAdapter = jsonGR.time {
                        self.getAdapterTime.text = "\(adapter) ~ \(timeAdapter)min"
                    }
                    
                    

                }
            }
        }
        
    }
    
    
    
    
// MARK: Show Custom Alert
    lazy var messagePopupView = MessagePopupView()
    
    func showCustomAlert(message: String) {
        
        messagePopupView.lable.attributedText = SupportResources().coloredStrind(string: message, color: .systemOrange)
        
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.addSubview(messagePopupView)
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hideCustomAlert), userInfo: nil, repeats: false)
        
        // First position
        let firstPosition = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height + 1.0))
        messagePopupView.transform = firstPosition

        // Show
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [self] in
            let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(self.view.bounds.height * 0.0))
            messagePopupView.transform = moveToBottom
        }, completion: nil)
        
        // При каждом нажатии дублируется view!
        messagePopupView.topAnchor.constraint(equalTo: navBar.topAnchor , constant: 8).isActive = true
        messagePopupView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16).isActive = true
        messagePopupView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -16).isActive = true
        messagePopupView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    }
    

    @objc func hideCustomAlert() {
//         Hide
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            let moveToTop = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height * 0.9))
            self.messagePopupView.transform = moveToTop
        } completion: { _ in
            self.messagePopupView.removeFromSuperview()
        }
    }
    
    

    
    
    
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
    
    // MARK: Background card
    let bgCardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 12
        return v
    }()
    
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
        
        // Send Item Stack
        let sendItemStack = UIStackView(arrangedSubviews: [sendLable,sendAmountTextField])
        sendItemStack.alignment = .fill
        sendItemStack.axis = .vertical
        sendItemStack.spacing = 4
        
        
        // getting Lable Stack
        let gettingLableStack = UIStackView(arrangedSubviews: [getLable,gettingNetwork, UIView(), getAdapterTime])
        gettingLableStack.alignment = .leading
        gettingLableStack.axis = .horizontal
        gettingLableStack.spacing = 0
        
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
//        mainStack.backgroundColor = .systemGray6
        
        // Background card
        bgCardView.addSubview(mainStack)
        
        view.addSubview(bgCardView)
        
        // MARK: Stack Constraints
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor.constraint(equalTo: bgCardView.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: bgCardView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: bgCardView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bgCardView.bottomAnchor, constant: -20),
            
            bgCardView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 24),
            bgCardView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 0),
            bgCardView.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 0),
//            firstStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            
        ])
    }
    
    // MARK: First BTN Action
    let firstTVC = SupportedCurrencyTableVC()
    @objc func fromBtnAction() {
        print("fromBtnAction press")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.presentedViewController == nil {
                let modalNav = UINavigationController(rootViewController: self.firstTVC)
//                modalNav.title = "From currency"
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
        setUpViews()
        setUpStack()
        
        setConstraints()
        
        
        // delegate
        firstTVC.firstDelegate = self
        secondTVC.secondDelegate = self
        
        // MARK: Target TextField
            
        sendAmountTextField.addTarget(Any?.self, action: #selector(sendTextFieldAction), for: .editingDidEnd)
        // Хотелось бы .allEditingEvents
        
//        showCustomAlert(message: "TestTestTestTes12312312312TestTestTestTestTestTestTestTestTestTestTestTe")
        
    }
    
    
    
    
    
    private func configureNavView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Exchange"
        
    }
    
    // MARK: Set up Views
    private func setUpViews() {
        
//        view.addSubview(formStack)
        view.addSubview(nextButton)
        
    }
    
    
    
}

// MARK: Constraints
extension ExchangeVC {
    private func setConstraints() {
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            nextButton.topAnchor.constraint(equalTo: bgCardView.bottomAnchor, constant: 24),
            nextButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}

//
//  ExchangeVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

class ExchangeVC: UIViewController, FirstDelegate, SecondDelegate  {
    
    // MARK: Delegate
    // Жудкий костыль для разных кнопок
    func getFirstTableValue(ticker: String) {
        firstCurrencyButton.lable.text = ticker.uppercased()
    }
    
    func getSecondTableValue(ticker: String) {
        secondCurrencyButton.lable.text = ticker.uppercased()
    }
    
    
    
    
    
    
// MARK: First Item
    let firstCurrencyButton: CurrencyButton = {
       let b = CurrencyButton()
        b.addTarget(Any.self, action: #selector(firstBtnAction), for: .touchUpInside)
        return b
    }()

    var sendAmountTextField = AmountTextField()
    
    let sendLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Send"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        l.textColor = .systemGray2
        return l
    }()
    
    let firstAnnotation: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Annotation!"
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
// - End First Item
    
// MARK: Second Item
    
    let secondCurrencyButton: CurrencyButton = {
       let b = CurrencyButton()
        b.addTarget(Any.self, action: #selector(secondBtnAction), for: .touchUpInside)
        return b
    }()

    var getAmountTextField = AmountTextField()
    
    let getLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Get"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        l.textColor = .systemGray2
        return l
    }()
    
// - End Second Item
    
    let formStack = UIStackView()
    
// MARK: setupStack
    func setupStack() {
        // First Item
        let sendInputStack = UIStackView()
        sendInputStack.translatesAutoresizingMaskIntoConstraints = false
        sendInputStack.axis = .horizontal
        sendInputStack.alignment = .firstBaseline
        sendInputStack.spacing = 0
        sendInputStack.addArrangedSubview(sendAmountTextField)
        sendInputStack.addArrangedSubview(firstCurrencyButton)
        
        let firstItemTopBar = UIStackView()
        firstItemTopBar.translatesAutoresizingMaskIntoConstraints = false
        firstItemTopBar.axis = .horizontal
        firstItemTopBar.alignment = .bottom
//        firstItemTopBar.spacing = 4
        firstItemTopBar.addArrangedSubview(sendLable)
        firstItemTopBar.addArrangedSubview(firstAnnotation)
        
        let firstItemStack = UIStackView()
        firstItemStack.translatesAutoresizingMaskIntoConstraints = false
        firstItemStack.axis = .vertical
        firstItemStack.spacing = 4
        firstItemStack.addArrangedSubview(firstItemTopBar)
        firstItemStack.addArrangedSubview(sendInputStack)
        //
        
        // Second Item
        let getInputStack = UIStackView()
        getInputStack.translatesAutoresizingMaskIntoConstraints = false
        getInputStack.axis = .horizontal
        getInputStack.alignment = .firstBaseline
        getInputStack.spacing = 0
        getInputStack.addArrangedSubview(getAmountTextField)
        getInputStack.addArrangedSubview(secondCurrencyButton)
        
        let secondItemStack = UIStackView()
        secondItemStack.translatesAutoresizingMaskIntoConstraints = false
        secondItemStack.axis = .vertical
        secondItemStack.spacing = 4
        secondItemStack.addArrangedSubview(getLable)
        secondItemStack.addArrangedSubview(getInputStack)
        //
        
        // Form Stack
        formStack.translatesAutoresizingMaskIntoConstraints = false
        formStack.spacing = 24
        formStack.axis = .vertical
        formStack.addArrangedSubview(firstItemStack)
        formStack.addArrangedSubview(secondItemStack)
        //
        
    }

    let testLable: UILabel = {
       let l = UILabel()
        l.text = "Test"
        
        return l
    }()



    
// MARK: First BTN Action
    let firstTVC = SupportedCurrencyTableVC()
    @objc func firstBtnAction() {
        let modalNav = UINavigationController(rootViewController: firstTVC)
        self.navigationController?.show(modalNav, sender: AnyObject.self)
    }
    
// MARK: Second BTN Action
    let secondTVC = SupportedCurrencyTableVC()
    @objc func secondBtnAction() {
        let modalNav = UINavigationController(rootViewController: secondTVC)
        self.navigationController?.show(modalNav, sender: AnyObject.self)
    }
    
    
    
// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        setupViews()
        setupStack()
        setConstraints()
        
        
        // delegate
        firstTVC.firstDelegate = self
        secondTVC.secondDelegate = self
        
        
//        let nm = ExchangeManager()
//        nm.getRate()
                
    }
    
    private func configureNavView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Exchange"
        
    }
    
    private func setupViews() {
        
        view.addSubview(formStack)

    }
    
    

}

// MARK: Constraints
extension ExchangeVC {
    private func setConstraints() {
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([

            formStack.topAnchor.constraint(equalTo: margin.topAnchor, constant: 32),
            formStack.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            formStack.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
            
            



        ])
    }
}

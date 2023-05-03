//
//  TransactionVC.swift
//  CryptoBalance
//
//  Created by Serj on 29.03.2023.
//

import UIKit

class TransactionVC: UIViewController {
    
//    lazy var messagePopupView = MessagePopupView(frame: .zero, imageSystemName: "checkmark.circle", imageColor: .systemGreen)
    
    
    // MARK: Values
    var fromValue: String?
    var toValue: String?
    var payValue: String?
    var payToAddressValue: String?
    var statusValue: String?
    var createdDateValue: String?
    var estimatedAmountValue: String?
    var receivingAddressValue: String?
    var refundAdressValue: String?
    var idTransactionValue: String?
    var userUniqueValue: String?

    // MARK: Configure Transaction Data
    func configureTransactionData() {
        
        guard
            let toValue = toValue,
            let fromValue = fromValue,
            let payValue = payValue,
            let payToAddressValue = payToAddressValue,
            let statusValue = statusValue,
            let createdDateValue = createdDateValue,
            let estimatedAmountValue = estimatedAmountValue,
            let receivingAddressValue = receivingAddressValue,
            let refundAdressValue = refundAdressValue,
            let idTransactionValue = idTransactionValue,
            let userUniqueValue = userUniqueValue
        else {
            print("error configure Transaction Data")
            return
        }
        
        fromToLable.text = "\(fromValue.uppercased()) • \(toValue.uppercased())"
        payLable.text = "Pay to address • \(payValue)"
        payToAddressLable.text = payToAddressValue
        statusLable.text = "Status: \(statusValue)"
        createdDateLable.text = "Created: \(createdDateValue)"
        estimatedAmountLable.text = "Estimated amount: \(estimatedAmountValue)"
        receivingAddressLable.text = "Receiving address: \(receivingAddressValue)"
        refundAdressLable.text = "Refund adress: \(refundAdressValue)"
        idTransactionLable.text = "ID transaction: \(idTransactionValue)"
        userUniqueLable.text = "User unique: \(userUniqueValue)"
        
    }
    
    
    // MARK: Large Lable Stack
    let payLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = " • "
        l.numberOfLines = 10
        l.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        l.textColor = .white
        return l
    }()
    let payToAddressLable = CustomLable14(frame: .zero, setText: "")
    
    // MARK: Text Stack
    let fromToLable = CustomLable14(frame: .zero, setText: "")
    let statusLable = CustomLable14(frame: .zero, setText: "")
    let createdDateLable = CustomLable14(frame: .zero, setText: "")
    let estimatedAmountLable = CustomLable14(frame: .zero, setText: "")
    let receivingAddressLable = CustomLable14(frame: .zero, setText: "")
    let refundAdressLable = CustomLable14(frame: .zero, setText: "")
    let idTransactionLable = CustomLable14(frame: .zero, setText: "")
    let userUniqueLable = CustomLable14(frame: .zero, setText: "")
    
    // MARK: Divider
    let transactionDivider: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 1
        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return v
    }()
    
    // MARK: Image Main
    let imageMain: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let configImage = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 176, weight: .light))
        
        iv.image = configImage
        iv.contentMode = .scaleAspectFit
        iv.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
//        iv.backgroundColor = .orange
        
        return iv
    }()
    
    // MARK: Copy Button
    let copyButton: UIButton = {
        
        let configImage = UIImage(systemName: "square.filled.on.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold))
        
        let iv = UIImageView(image: configImage)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addSubview(iv)
//        b.backgroundColor = .orange
        
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        iv.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(copyAddress), for: .touchUpInside)
        return b
    }()
    
    // MARK: Copy Button Action
    @objc func copyAddress() {
        guard let valPayToAddressLable = payToAddressLable.text else { return }
        UIPasteboard.general.string = valPayToAddressLable
         
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.copyButton.isEnabled = false
            self.showSmallCustomAnnotation(message: "Address copied", imageSystemName: "checkmark.circle", imageColor: .systemGreen)
        }
        // Исключил прокликивание Ломает анимацию и спам
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.copyButton.isEnabled = true
        }
        
    }
    
    

   
    
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

//        setDismissNavButtonItem(selectorStr: Selector(("popToRootButtonAction")))
        
        setUpStack()
        
        configureTransactionData()
        
    }
    

        
    // MARK: Set up Stack
    private func setUpStack() {
        
        // large Lable Stack
        let largeLableStack = UIStackView(arrangedSubviews: [payLable,payToAddressLable])
        largeLableStack.translatesAutoresizingMaskIntoConstraints = false
        largeLableStack.axis = .vertical
        largeLableStack.alignment = .fill
        largeLableStack.spacing = 8
        
        // Large Lable Item Stack
        let largeLableItemStack = UIStackView(arrangedSubviews: [largeLableStack,copyButton])
        largeLableItemStack.axis = .horizontal
        largeLableItemStack.alignment = .center
//        largeLableItemStack.distribution = .fill
        largeLableItemStack.spacing = 16
        
        
        // Text Stack
        let textStack = UIStackView(arrangedSubviews: [
            largeLableItemStack,
            transactionDivider,
            
            fromToLable,
            statusLable,
            createdDateLable,
            estimatedAmountLable,
            receivingAddressLable,
            refundAdressLable,
            idTransactionLable,
            userUniqueLable
        ])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.alignment = .fill
        textStack.spacing = 16
        
        
        // Content Stack
        let contentStack = UIStackView(arrangedSubviews: [imageMain, textStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 40
        
        
        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [UIView(),contentStack,UIView()])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .equalCentering

        
        // set up View
        view.addSubview(mainStack)
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
        
            mainStack.topAnchor.constraint(equalTo: view.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    

}




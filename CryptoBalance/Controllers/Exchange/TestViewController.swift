//
//  TestViewController.swift
//  CryptoBalance
//
//  Created by Serj on 06.03.2023.
//

import UIKit
//
//class TestViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
////        view.addSubview(<#T##view: UIView##UIView#>)
//        setupStack()
//    }
//
//    // MARK: From Item Stack
//    let fromLable: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "From"
//        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        l.textColor = .systemGray
//        return l
//    }()
//
//    let fromCurrencyButton: CurrencyButtonV2 = {
//        let b = CurrencyButtonV2()
////        b.addTarget(Any.self, action: #selector(firstBtnAction), for: .touchUpInside)
//        return b
//    }()
//
//
//    // MARK: To Item Stack
//    let toCurrencyButton: CurrencyButtonV2 = {
//        let b = CurrencyButtonV2()
////        b.addTarget(Any.self, action: #selector(secondBtnAction), for: .touchUpInside)
//        b.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        return b
//    }()
//
//    let toLable: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "To"
//        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        l.textColor = .systemGray
//        return l
//    }()
//
//
//    // MARK: Send Item Stack
//    let sendLable: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "Send"
//        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        l.textColor = .systemGray
//        return l
//    }()
//    var sendAmountTextField = AmountTextField()
//
//
//    // MARK: Get Item Stack
//    let getLable: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "You'll get • DOGE"
//        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        l.textColor = .systemGray
//        return l
//    }()
//    let getAmountLable: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "00000000.00000000"
//        l.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        l.textColor = .white
//        l.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return l
//    }()
//    let getDivider: UIView = {
//        let v = UIView()
////        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .systemGray5
//        v.layer.cornerRadius = 1
////        v.frame = CGRect(x: 2, y: 2, width: 2, height: 2)
//        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        return v
//    }()
//
//    // MARK: Setup Stack
//    func setupStack() {
//
//        // From
//        let fromItemStack = UIStackView()
//        fromItemStack.translatesAutoresizingMaskIntoConstraints = false
//        fromItemStack.spacing = 4
//        fromItemStack.axis = .vertical
//        fromItemStack.alignment = .fill
//        fromItemStack.addArrangedSubview(fromLable)
//        fromItemStack.addArrangedSubview(fromCurrencyButton)
//
//        // To
//        let toItemStack = UIStackView()
//        fromItemStack.translatesAutoresizingMaskIntoConstraints = false
//        toItemStack.spacing = 4
//        toItemStack.axis = .vertical
//        toItemStack.alignment = .fill
//        toItemStack.addArrangedSubview(toLable)
//        toItemStack.addArrangedSubview(toCurrencyButton)
//
//        // First Stack
//        let firstStack = UIStackView(arrangedSubviews: [fromItemStack, toItemStack])
//        firstStack.translatesAutoresizingMaskIntoConstraints = false
//        firstStack.spacing = 16
//        firstStack.axis = .horizontal
//        firstStack.alignment = .center
//        firstStack.distribution = .fillEqually
//
//        // Send Item Stack
//        let sendItemStack = UIStackView(arrangedSubviews: [sendLable,sendAmountTextField])
//        sendItemStack.alignment = .fill
//        sendItemStack.axis = .vertical
//        sendItemStack.spacing = 4
//
//        // Get Item Stack
//        let getItemStack = UIStackView(arrangedSubviews: [getLable,getAmountLable,getDivider])
//        getItemStack.alignment = .fill
//        getItemStack.axis = .vertical
//        getItemStack.spacing = 4
//
//        // Main Stack
//        let mainStack = UIStackView(arrangedSubviews: [firstStack,sendItemStack,getItemStack])
//        mainStack.translatesAutoresizingMaskIntoConstraints = false
//        mainStack.axis = .vertical
//        mainStack.alignment = .fill
//        mainStack.spacing = 16
////        mainStack.backgroundColor = .systemGray6
//
//        // Background card
//        let bgCardView: UIView = {
//            let v = UIView()
//            v.translatesAutoresizingMaskIntoConstraints = false
//            v.backgroundColor = .systemGray6
//            v.layer.cornerRadius = 12
//            return v
//        }()
//
//        bgCardView.addSubview(mainStack)
//        view.addSubview(bgCardView)
//
//        let margin = view.layoutMarginsGuide
//        NSLayoutConstraint.activate([
//
//            mainStack.topAnchor.constraint(equalTo: bgCardView.topAnchor, constant: 20),
//            mainStack.leadingAnchor.constraint(equalTo: bgCardView.leadingAnchor, constant: 16),
//            mainStack.trailingAnchor.constraint(equalTo: bgCardView.trailingAnchor, constant: -16),
//            mainStack.bottomAnchor.constraint(equalTo: bgCardView.bottomAnchor, constant: -20),
//
//            bgCardView.topAnchor.constraint(equalTo: margin.topAnchor, constant: 32),
//            bgCardView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 0),
//            bgCardView.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 0),
////            firstStack.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
//
//        ])
//    }
//
//
//
//}

//
//  TransactionsTVCell.swift
//  CryptoBalance
//
//  Created by Serj on 27.03.2023.
//

import UIKit

class TransactionsTVCell: UITableViewCell {

    let idTransactionsTVCell = "idTransactionsTVCell"
    
    
    // MARK: Status Lable
    private let statusLable: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "?"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
//        l.backgroundColor = .systemRed
//        l.textColor = .systemRed
        return l
    }()
    
    // MARK: Value From
    private let valueFrom: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "? • ?"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    // MARK: Value To
    private let valueTo: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "? • ?"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray
        return l
    }()
    
    // MARK: Date Lable
    private let dateLable: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "?"
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .systemGray3
        
//        l.backgroundColor = .systemBlue
        
        return l
    }()
    
    
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.backgroundColor = .systemGray6
        setUpStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        if selected {
//            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseInOut) {
//                self.backgroundColor = .systemGray5
//            } completion: { _ in
//                self.backgroundColor = .systemGray6
//            }
//        }
//    }
    
    
    
    func configure(status: String, date: String, from: String, to: String) {
        statusLable.text = status
        dateLable.text = date
        valueFrom.text = from
        valueTo.text = to
    }
    

    
    // MARK: Set up Stack
    private func setUpStack() {
        // First Stack
        let firstStack = UIStackView(arrangedSubviews: [statusLable, UIView(), dateLable])
        firstStack.axis = .horizontal
        firstStack.alignment = .fill
        
        
        // Second Stack
        let secondStack = UIStackView(arrangedSubviews: [valueFrom, valueTo])
        secondStack.axis = .vertical
        secondStack.alignment = .fill
        secondStack.spacing = 8
        
        let mainStack = UIStackView(arrangedSubviews: [firstStack, secondStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = 8
        
        self.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    


}

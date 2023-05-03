//
//  TableViewCell.swift
//  CryptoBalance
//
//  Created by Serj on 13.01.2023.
//

import UIKit

class WalletTVCell: UITableViewCell {
    
    static var idWalletTVCell = "idWalletTVCell"
    
    // MARK: networkCC
    let networkCC: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return l
    }()
    // MARK: balanceCC
    let balanceCC: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return l
    }()
    // MARK: iconCC
    let iconCC: UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = false
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray6

        setUpstack()
    }
    
    
    
    // MARK: configure
    func configure(network: String, balance: String, iconName: String) {
        networkCC.text = network
        balanceCC.text = balance
        iconCC.image = UIImage(named: iconName )
    }
    
    
    // MARK: Set up Stack
    private func setUpstack() {
        
        let iconCCFrameView: UIView = {
           let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
//            v.backgroundColor = .orange
            
            v.addSubview(iconCC)
            iconCC.heightAnchor.constraint(equalToConstant: 30).isActive = true
            iconCC.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            iconCC.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
            iconCC.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true
            
            iconCC.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            iconCC.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
            return v
        }()
        
        // First Stack
        let firstStack = UIStackView(arrangedSubviews: [networkCC, balanceCC])
        firstStack.axis = .vertical
        firstStack.alignment = .fill
        firstStack.spacing = 8

        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [iconCCFrameView, firstStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = 16

        
        // set up view
        self.addSubview(mainStack)
        
        // constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//
////        if selected {
////            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseInOut) {
////                self.backgroundColor = .systemGray5
////            } completion: { _ in
////                self.backgroundColor = .systemGray6
////            }
////        }
//
//    }
    
    
}



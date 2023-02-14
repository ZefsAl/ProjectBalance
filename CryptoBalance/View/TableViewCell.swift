//
//  TableViewCell.swift
//  CryptoBalance
//
//  Created by Serj on 13.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var idTableViewCell = "idTableViewCell"
    
    let networkCC: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        return l
    }()
    let balanceCC: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return l
    }()
    
    let iconCC: UIImageView = {
       let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    
    func configure(network: String, balance: String, iconName: String) {
        networkCC.text = network
        balanceCC.text = balance
        iconCC.image = UIImage(named: iconName )
    }
    
    
    private func setupView() {
        self.addSubview(networkCC)
        self.addSubview(balanceCC)
        self.addSubview(iconCC)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //        // Configure the view for the selected state
    //    }
    
}


extension TableViewCell {
    private func setConstraints() {
        //        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            iconCC.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconCC.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconCC.widthAnchor.constraint(equalToConstant: 24),
            iconCC.heightAnchor.constraint(equalToConstant: 24),
            
            networkCC.centerYAnchor.constraint(equalTo: centerYAnchor),
            networkCC.leadingAnchor.constraint(equalTo: iconCC.trailingAnchor, constant: 16),
            
            balanceCC.centerYAnchor.constraint(equalTo: centerYAnchor),
            balanceCC.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
}

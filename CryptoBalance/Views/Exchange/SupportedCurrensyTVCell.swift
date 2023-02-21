//
//  ExchangeTVCell.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

class SupportedCurrensyTVCell: UITableViewCell {

    static var idExchangeTVCell = "idExchangeTVCell"
    
    private let networkLable: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = ""
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return l
    }()
    
    private let nameLable: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = ""
        l.textColor = .lightGray
        return l
    }()
    
    func configure(setNetwork: String, setName: String) {
        networkLable.text = setNetwork
        nameLable.text = setName
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.translatesAutoresizingMaskIntoConstraints = false // НЕ отключать
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        addSubview(networkLable)
        addSubview(nameLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

extension SupportedCurrensyTVCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            networkLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            networkLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            nameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}

//
//  MainTableView.swift
//  CryptoBalance
//
//  Created by Serj on 12.01.2023.
//

import UIKit

class WalletTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        translatesAutoresizingMaskIntoConstraints = false
        register(WalletTVCell.self, forCellReuseIdentifier: WalletTVCell.idWalletTVCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







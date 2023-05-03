//
//  MainTableView.swift
//  CryptoBalance
//
//  Created by Serj on 12.01.2023.
//

import UIKit

class WalletTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        backgroundColor = .systemGray6
        self.layer.cornerRadius = 12
        self.isScrollEnabled = false
        
        translatesAutoresizingMaskIntoConstraints = false
        register(WalletTVCell.self, forCellReuseIdentifier: WalletTVCell.idWalletTVCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







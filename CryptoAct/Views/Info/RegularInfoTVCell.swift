//
//  InfoTVC.swift
//  CryptoBalance
//
//  Created by Serj on 19.04.2023.
//

import UIKit

class RegularInfoTVCell: UITableViewCell {

    let idRegularInfoTVCell = "idRegularInfoTVCell"
    
    // MARK: title
    private let title: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Settings"
//        l.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        l.textColor = .white
        return l
    }()
    
    
    // MARK: Icon
    let icon: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.tintColor = .white
        return i
    }()
    
    // MARK: image BG
    let iconBG: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemPink
        v.layer.cornerRadius = 6
        
        v.heightAnchor.constraint(equalToConstant: 28).isActive = true
        v.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        return v
    }()
    

    

    
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        // Config
        self.backgroundColor = .systemGray6
//        self.accessoryType = .disclosureIndicator
        self.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        
        setUpStack()
    }

    func configure(with model: InfoRegularCell) {
        icon.image = model.icon
        title.text = model.title
        iconBG.backgroundColor = model.iconBGC
        
    }
    
    
    // MARK: Set up Stack
    private func setUpStack() {
        
        // Icon
        iconBG.addSubview(icon)
        let padding: CGFloat = 3
        icon.topAnchor.constraint(equalTo: iconBG.topAnchor, constant: padding).isActive = true
        icon.bottomAnchor.constraint(equalTo: iconBG.bottomAnchor, constant: -padding).isActive = true
        icon.leadingAnchor.constraint(equalTo: iconBG.leadingAnchor, constant: padding).isActive = true
        icon.trailingAnchor.constraint(equalTo: iconBG.trailingAnchor, constant: -padding).isActive = true
        icon.centerXAnchor.constraint(equalTo: iconBG.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: iconBG.centerYAnchor).isActive = true
        
        
        // Title
        let titleStack = UIStackView(arrangedSubviews: [title])
        titleStack.axis = .vertical
        titleStack.alignment = .fill
        titleStack.spacing = 8
        
        
        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [iconBG, titleStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = 16
        
        
        self.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

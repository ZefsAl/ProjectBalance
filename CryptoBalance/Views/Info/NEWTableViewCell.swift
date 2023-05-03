//
//  NEWTableViewCell.swift
//  CryptoBalance
//
//  Created by Serj on 19.04.2023.
//

import UIKit

class NEWTableVieasaswCell: UITableViewCell {
    
    var idNEWTableViewCell = "idNEWTableViewCell"
    
    
    // MARK: title
    let title: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return l
    }()
    
    // MARK: iconCC
    let icon: UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = false
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let iconBG: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemOrange
        v.layer.cornerRadius = 6
        return v
    }()
    

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemGray6
//        selectionStyle = .none
//        setUpstack()
        newSetUpstack()
    }
    
    
    
    // MARK: configure
    func configure(with model: InfoOptions) {
        icon.image = model.icon
        title.text = model.title
        icon.backgroundColor = model.iconBGC
    }
    
    
    // MARK: Set up Stack
    private func setUpstack() {
        
        
//        iconBG.addSubview(icon)
//        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
//
//        icon.leadingAnchor.constraint(equalTo: icon.leadingAnchor).isActive = true
//        icon.trailingAnchor.constraint(equalTo: icon.trailingAnchor).isActive = true
        
        
//        icon.centerXAnchor.constraint(equalTo: icon.centerXAnchor).isActive = true
//        icon.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        
        let iconCCFrameView: UIView = {
           let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = .orange

            v.addSubview(icon)
            
            icon.heightAnchor.constraint(equalToConstant: 28).isActive = true
            icon.widthAnchor.constraint(equalToConstant: 28).isActive = true

            icon.topAnchor.constraint(equalTo: v.topAnchor, constant: 2).isActive = true
            icon.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 2).isActive = true
            icon.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -2).isActive = true
            icon.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -2).isActive = true

            icon.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            icon.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
//            v.topAnchor.constraint(equalTo: icon.topAnchor, constant: 2).isActive = true
//            v.leadingAnchor.constraint(equalTo: icon.leadingAnchor, constant: 2).isActive = true
//            v.trailingAnchor.constraint(equalTo: icon.trailingAnchor, constant: -2).isActive = true
//            v.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: -2).isActive = true


            
            return v
        }()
        
        // First Stack
        let firstStack = UIStackView(arrangedSubviews: [title])
        firstStack.axis = .vertical
        firstStack.alignment = .fill
        firstStack.spacing = 8


        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [iconCCFrameView, firstStack])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = 16

        mainStack.backgroundColor = .red
        
        // set up view
        self.addSubview(mainStack)
        
        // constraints
        NSLayoutConstraint.activate([
            
            
            
            
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
//            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
//            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
        ])
    }
    
    // MARK: newSetUpstack
    private func newSetUpstack() {
        
        

        
        // set up view
        iconBG.addSubview(icon)
        self.addSubview(iconBG)
//        self.contentView.addSubview(iconBG)
        
        
        // constraints
        NSLayoutConstraint.activate([
            
            icon.heightAnchor.constraint(equalToConstant: 28),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.topAnchor.constraint(equalTo: iconBG.topAnchor, constant: 2),
            icon.leadingAnchor.constraint(equalTo: iconBG.leadingAnchor, constant: 2),
            icon.trailingAnchor.constraint(equalTo: iconBG.trailingAnchor, constant: -2),
            icon.bottomAnchor.constraint(equalTo: iconBG.bottomAnchor, constant: -2),
            icon.centerXAnchor.constraint(equalTo: iconBG.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: iconBG.centerYAnchor),
            
            
            
            
//            iconBG.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            iconBG.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
////            iconBG.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            iconBG.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
            iconBG.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            iconBG.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            iconBG.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            iconBG.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        
            
            
//            iconBG.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//            iconBG.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
////            iconBG.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
//            iconBG.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            
            
        ])
        
//        self.tableView.rowHeight =
//        self.rowhe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//
//        if selected {
//            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseInOut) {
//                self.backgroundColor = .systemGray5
//            } completion: { _ in
//                self.backgroundColor = .systemGray6
//            }
//        }
//
//    }
    
    
}


// MARK: NEWTableViewCell

class NEWTableViewCell: UITableViewCell {
    
    var idNEWTableViewCell = "idNEWTableViewCell"
    
    // MARK: title
    let title: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "plug"
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return l
    }()
    
    // MARK: icon
    let icon: UIImageView = {
       let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = false
//        i.translatesAutoresizingMaskIntoConstraints = false
        i.backgroundColor = .systemOrange
        
        i.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        
        
        return i
    }()
    

    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        backgroundColor = .systemGray6

        selectionStyle = .none
        setUpstack()
    }
    
    
    
    // MARK: configure
    func configure(with model: InfoOptions) {
//        icon.image = model.icon
//        title.text = model.title
//        icon.backgroundColor = model.iconBGC

        
        icon.image = UIImage(systemName: "circle.fill")
        title.text = "model.title"
        icon.backgroundColor = .systemGreen
        
    }
    
    
    // MARK: Set up Stack
    private func setUpstack() {
        
        let iconCCFrameView: UIView = {
           let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
//            v.backgroundColor = .orange
            
            v.addSubview(icon)
//            icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
//            icon.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
//            icon.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true
            
            icon.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
            icon.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
            return v
        }()
        
        // First Stack
        let firstStack = UIStackView(arrangedSubviews: [title])
        firstStack.axis = .vertical
        firstStack.alignment = .fill
        firstStack.spacing = 8

        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [icon, title])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.alignment = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = 16

        mainStack.backgroundColor = .systemPink
        
        // set up view
        self.addSubview(mainStack)
        
        // constraints
        NSLayoutConstraint.activate([
            
            icon.heightAnchor.constraint(equalToConstant: 28),
            icon.widthAnchor.constraint(equalToConstant: 28),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            
//            self.heightAnchor.constraint(equalToConstant: 100)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//
//        if selected {
//            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseInOut) {
//                self.backgroundColor = .systemGray5
//            } completion: { _ in
//                self.backgroundColor = .systemGray6
//            }
//        }
//
//    }
    
    
}



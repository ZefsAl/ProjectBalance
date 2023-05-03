//
//  AddWalletVC.swift
//  CryptoBalance
//
//  Created by Serj on 14.01.2023.
//

import UIKit

class AddWalletVC: UIViewController, CurrencyPickerProtocol {
    
    // Delegate
    var rowVal: Int = 0 // Где то еще используется и зачем вооще ?
    func didSelect(row: Int) {
        rowVal = row
    }
    
    
// MARK: Instances
    private var pickerTextField = PickerTextField()
    let nm = WalletManager()
    
    var addButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .systemGray3
        
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Add"
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        l.isUserInteractionEnabled = false
        b.addSubview(l)
        l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
        l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        
//        b.setTitle("Add", for: .normal)
//        b.setTitle
//        b.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        b.layer.cornerRadius = 12
        
        return b
    }()
    
    var addressTextField: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        tf.backgroundColor = .systemGray5
        tf.layer.cornerRadius = 12
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Enter public address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.tintColor = .white
        
        // Margins inside
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.leftViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.rightViewMode = .always
        
        return tf
    }()
    
    
    
    
// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setConstraints()
        setDismissNavButtonItem(selectorStr: Selector(("dismissButtonAction")))
        
        // Validation target's
        pickerTextField.addTarget(self, action: #selector(validationFields), for: .allEditingEvents)
        addressTextField.addTarget(self, action: #selector(validationFields), for: .allEditingEvents)
        
        // Configure
        view.backgroundColor = .systemGray6
        navigationItem.title = "Add wallet"
        navigationItem.largeTitleDisplayMode = .never
        
        
                
    }
    
    // MARK: Configure Nav Item
    func configureNavItem() {
        let dismissButtonView: UIView = {
            let iv = UIImageView()
            
            iv.image = UIImage(systemName: "xmark.circle.fill")
//            iv.contentMode = UIView.ContentMode.scaleToFill
            
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .systemGray2
            iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
            iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
            return iv
        }()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(barItemAction))
        dismissButtonView.addGestureRecognizer(gesture)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dismissButtonView)
    }
    @objc func barItemAction() {
        self.dismiss(animated: true)
    }
    
    
// MARK: Request queryBalance
    func doFetchRequest() {
        getWalletValue { [weak self] network, address in
            guard let self = self else { return }
            self.nm.queryBalance(network: network, address: address) { jsonBM in

                let walletModel = WalletModel()
                walletModel.address = jsonBM.address
                walletModel.balance = "\(SupportResources().convertSatoshi(jsonBM.balance))"
                walletModel.dateSort = Date()
                walletModel.network = network
                walletModel.finalNTX = String(jsonBM.finalNTX)
                CoreDataManager.shared.saveContext()
            }
        }
    }
    
// MARK: Button action
    @objc func addButtonPressed() {
        doFetchRequest()
        print("addButtonPressed")
        self.dismiss(animated: true)
    }
    
// MARK: Validation Fields
    @objc func validationFields()  {
        // address
        guard let addressVal = addressTextField.text else { return }

        let filterStr = addressVal.filter { $0 != " " }
        let filtered = filterStr.count
        
        // validation
        if  filtered >= 9 &&
            (pickerTextField.text != "Not selected" && pickerTextField.text != "") {
            addButton.isEnabled = true
            addButton.backgroundColor = UIColor(named: "PrimaryColor")
            addButton.addTarget(nil, action: #selector(addButtonPressed), for: .touchUpInside)
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .systemGray3
        }
        
    }
    
    
    
    // MARK: Completion
    func getWalletValue(completion: @escaping (_ network: String, _ address: String) -> Void ) {
        guard let forShortVal = pickerTextField.text else { return }
        // Костыль для запроса
        let resource = SupportResources().getShortNetwork(string: forShortVal)
        let netvorkVal = resource
        
        guard let addressVal = addressTextField.text else { return }
        completion(netvorkVal, addressVal)
    }
    
    
    private func setUpViews() {
        view.addSubview(addButton)
        view.addSubview(addressTextField)
        view.addSubview(pickerTextField)
    }
    
}

// MARK: Constraints
extension AddWalletVC {
    private func setConstraints() {
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            pickerTextField.topAnchor.constraint(equalTo: margin.topAnchor, constant: 40),
            pickerTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            pickerTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            pickerTextField.heightAnchor.constraint(equalToConstant: 60),
            
            addressTextField.topAnchor.constraint(equalTo: pickerTextField.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            addressTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 60),
            
            addButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 24),
            addButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant:  -16),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}


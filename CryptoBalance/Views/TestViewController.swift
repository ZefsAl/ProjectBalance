//
//  TestViewController.swift
//  CryptoBalance
//
//  Created by Serj on 25.04.2023.
//

import UIKit

class TestViewController: UIViewController {

    var seconds: Int = 900
    var timer: Timer = Timer()
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @objc func updateTimer() {
         if seconds < 1 {
              timer.invalidate()
              //Send alert to indicate "time's up!"
         } else {
              seconds -= 1
              lable.text = timeString(time: TimeInterval(seconds))
         }
    }
    
    
    let lable: UILabel = {
       let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .systemOrange
        l.text = "1234"
        
        return l
    }()
    
    
    func setUpTimer() {
        
//        let timer = CountDownTimer()
//        lable.text = timer.displayedStr
//        lable.text = timer.timeString(time: TimeInterval(900))
//        timer.runTimer()
//        lable.text = "\(timer.seconds)"
        runTimer()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        
        setUpTimer()
        
        
        view.addSubview(lable)
        NSLayoutConstraint.activate([
        
            lable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        ])
    }
    
    
    

    

}

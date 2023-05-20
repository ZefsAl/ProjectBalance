//
//  CountDownTimer.swift
//  CryptoBalance
//
//  Created by Serj on 25.04.2023.
//

import Foundation

class CountDownTimer {
    
    var seconds: Int
    var timer: Timer = Timer()
    var isTimerRunning: Bool
//    var displayTo: String
    
    var displayedStr = ""
    
    init(seconds: Int, isTimerRunning: Bool, displayedStr: String = "") {
        self.seconds = seconds
        self.isTimerRunning = isTimerRunning
        self.displayedStr = displayedStr
        
    }
    
//    init(seconds: Int, isTimerRunning: Bool) {
//        self.seconds = seconds
////        self.timer = timer
//        self.isTimerRunning = isTimerRunning
//
//        super.init()
////        runTimer()
//
//    }
    
    
    
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
             
             
             displayedStr = timeString(time: TimeInterval(seconds))
//              timerLabel.text = timeString(time: TimeInterval(seconds))
         }
    }
    
}

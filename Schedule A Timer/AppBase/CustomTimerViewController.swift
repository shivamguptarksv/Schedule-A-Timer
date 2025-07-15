//
//  CustomTimerViewController.swift
//  Schedule A Timer
//
//  Created by Saurabh Gupta on 15/07/25.
//

import UIKit

class CustomTimerViewController: UIViewController {
  
  var timer: Timer?
  var remaningSecond = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private let timerLabel: UILabel = {
    let timerLabel = UILabel()
    timerLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.textColor = .label
    return timerLabel
  }()
  
  private let startButton = UIButton(type: .system)
  
  private let pauseButton = UIButton(type: .system)
  
  private let resetButton = UIButton(type: .system)
  
  
  func setupView() {
    
    setupAction()
    
    view.backgroundColor = .lightGray.withAlphaComponent(0.3)
    view.addSubview(timerLabel)
    view.addSubview(startButton)
    view.addSubview(pauseButton)
    view.addSubview(resetButton)
    
    timerLabel.text = "00:00:00"
    startButton.setTitle("Start", for: .normal)
    pauseButton.setTitle("Pause", for: .normal)
    resetButton.setTitle("Reset", for: .normal)
    
    NSLayoutConstraint.activate([
      timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
      
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
      
      pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
      
      resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
      
    ])
  }
  
  func setupAction() {
    startButton.translatesAutoresizingMaskIntoConstraints = false
    pauseButton.translatesAutoresizingMaskIntoConstraints = false
    resetButton.translatesAutoresizingMaskIntoConstraints = false

    startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
    pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
    resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
  }
  
  func scheduleTimer() {
    if timer == nil {
      timer = Timer(timeInterval: 1,
                    target: self,
                    selector: #selector(updateTimer),
                    userInfo: nil,
                    repeats: true)
      if let timer {
        RunLoop.main.add(timer, forMode: .common)
      }
      
      /*
      timer = Timer.scheduledTimer(timeInterval: 1,
                                   target: self,
                                   selector: #selector(updateTimer),
                                   userInfo: nil,
                                   repeats: true)
       */
    }
  }
  
  @objc func updateTimer() {
    DispatchQueue.main.async {
      self.timerLabel.text = "\(self.remaningSecond)"
    }
    remaningSecond-=1
    guard remaningSecond <= 0 else { return }
    popUpAlert(message: "Timer is over")
    pauseTimer()
  }
  
  func popUpAlert(message: String) {
    let alertViewController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alertViewController.addAction(UIAlertAction(title: "Ok", style: .default))
    self.present(alertViewController, animated: true)
  }
  
  @objc func startTimer() {
    scheduleTimer()
    popUpAlert(message: "Timer started")
  }
  
  @objc func pauseTimer() {
    if timer != nil {
      timer?.invalidate()
      timer = nil
    }
  }
  
  @objc func resetTimer() {
    remaningSecond = 60
    pauseTimer()
    DispatchQueue.main.async {
      self.timerLabel.text = "\(self.remaningSecond)"
    }
  }
  
}

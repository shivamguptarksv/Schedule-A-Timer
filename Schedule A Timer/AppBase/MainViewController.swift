//
//  MainViewController.swift
//  Schedule A Timer
//
//  Created by Saurabh Gupta on 15/07/25.
//

import UIKit

class MainViewController: UIViewController {
  
  var timer: Timer?
  var remaningSecond = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private let timerLabel: UILabel = {
    let timerLabel = UILabel()
    timerLabel.font = .systemFont(ofSize: 56.0, weight: .bold)
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.textColor = .label
    return timerLabel
  }()
  
  private let horizontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.spacing = 50
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let startButton = UIButton(type: .system)
  
  private let pauseButton = UIButton(type: .system)
  
  private let resetButton = UIButton(type: .system)
  
  
  func setupView() {
    
    setupAction()
    
    view.backgroundColor = .orange.withAlphaComponent(0.3)
    view.addSubview(timerLabel)
    view.addSubview(horizontalStackView)
    //    view.addSubview(startButton)
    //    view.addSubview(pauseButton)
    //    view.addSubview(resetButton)
    
    horizontalStackView.addArrangedSubview(startButton)
    horizontalStackView.addArrangedSubview(pauseButton)
    horizontalStackView.addArrangedSubview(resetButton)
    
    timerLabel.text = "00:00:00"
    startButton.setTitle("Start", for: .normal)
    pauseButton.setTitle("Pause", for: .normal)
    resetButton.setTitle("Reset", for: .normal)
    
    NSLayoutConstraint.activate([
      timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
      
//      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
//      
//      pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      pauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
//      
//      resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
      
      horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      horizontalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
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
      if remaningSecond > 0 {
          remaningSecond -= 1
          timerLabel.text = "\(remaningSecond)"
      } else {
          pauseTimer()
          popUpAlert(message: "Timer is over")
      }
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
  
  func formatTime(_ totalSeconds: Int) -> String {
      let hours = totalSeconds / 3600
      let minutes = (totalSeconds % 3600) / 60
      let seconds = totalSeconds % 60
      return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
  
}


/*
 
 stackView.isLayoutMarginsRelativeArrangement = true
 stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

 
 */

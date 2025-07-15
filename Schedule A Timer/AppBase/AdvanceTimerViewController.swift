import UIKit

class SystemTimerViewController: UIViewController {

    private var timer: Timer?
    private var endTime: Date?
    private var countdownDuration: TimeInterval = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:01:00"
        return label
    }()

    private let startButton = UIButton(type: .system)
    private let pauseButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)

    private func setupView() {
        view.backgroundColor = .systemGray6
        setupButtons()

        [timerLabel, startButton, pauseButton, resetButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),

            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }

    private func setupButtons() {
        [startButton, pauseButton, resetButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        startButton.setTitle("Start", for: .normal)
        pauseButton.setTitle("Pause", for: .normal)
        resetButton.setTitle("Reset", for: .normal)

        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
    }

    @objc private func startTimer() {
        if timer != nil { return } // Prevent multiple timers
        
        startSystemTimer(duration: countdownDuration) { [weak self] remaining in
            self?.updateLabel(with: remaining)
        } onComplete: { [weak self] in
            self?.popUpAlert(message: "Timer Completed!")
        }
    }

    @objc private func pauseTimer() {
        timer?.invalidate()
        timer = nil
        
        if let endTime = endTime {
            let remaining = max(endTime.timeIntervalSinceNow, 0)
            countdownDuration = remaining
        }
    }

    @objc private func resetTimer() {
        pauseTimer()
        countdownDuration = 60
        updateLabel(with: countdownDuration)
    }

    private func startSystemTimer(duration: TimeInterval,
                                  onTick: @escaping (TimeInterval) -> Void,
                                  onComplete: @escaping () -> Void) {
        countdownDuration = duration
        endTime = Date().addingTimeInterval(duration)
        
        // ✅ Fire immediately with the initial value
        onTick(duration)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let endTime = self?.endTime else { return }
            let remaining = endTime.timeIntervalSinceNow

            if remaining <= 0 {
                timer.invalidate()
                self?.timer = nil
                onTick(0)
                onComplete()
            } else {
                onTick(remaining)
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func updateLabel(with seconds: TimeInterval) {
        let sec = Int(seconds)
        let hours = sec / 3600
        let minutes = (sec % 3600) / 60
        let seconds = sec % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func popUpAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

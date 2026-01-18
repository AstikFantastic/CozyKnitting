import UIKit

extension CounterViewController {
    func showResetAlert() {
        let alert = UIAlertController(
            title: "Reset Counter?",
            message: "\n\n",
            preferredStyle: .alert
        )
        
        let switchView = UISwitch(frame: .zero)
        switchView.isOn = false
        
        let label = UILabel(frame: .zero)
        label.text = "Do not show this alert again"
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        container.addSubview(switchView)
        container.addSubview(label)
        
        [switchView, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            switchView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            switchView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            label.leadingAnchor.constraint(equalTo: switchView.trailingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        alert.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 70),
            container.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            if switchView.isOn {
                self?.presenter.setNeverShowResetAlert(true)
            }
            self?.presenter.didTapReset()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

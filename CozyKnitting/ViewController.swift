import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        
        setupUI()
    }

    private func setupUI() {
        let testButton = UIButton()
        testButton.setTitle("Test Button", for: .normal)
        testButton.backgroundColor = AppColors.buttonBackgroungColor
        testButton.layer.cornerRadius = 5
        view.addSubview(testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testButton.widthAnchor.constraint(equalToConstant: 150),
            testButton.heightAnchor.constraint(equalToConstant: 40),
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


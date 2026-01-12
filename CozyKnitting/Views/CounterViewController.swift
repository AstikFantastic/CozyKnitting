import UIKit

protocol CounterViewProtocol: AnyObject {}

protocol CounterPresenterProtocol {

}
protocol CounterRouterProtocol {}

final class CounterViewController: UIViewController, CounterViewProtocol {
    
    private let stitchesCount = UILabel()
    private let prosButton = UIButton()
    private let consButton = UIButton()
    private let resetButton = UIButton()
    private let saveNewProjectButton = UIButton()
    private let addToCurrentButton = UIButton()
    
    
    var presenter: CounterPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        title = "Stitches Counter"
        
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {

        let buttonSize: CGFloat = 100
        
        stitchesCount.text = "999"
        stitchesCount.textAlignment = .center
        stitchesCount.font = UIFont(name: "Arial Rounded MT Bold", size: 100)

        prosButton.setTitle("+", for: .normal)
        prosButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 100)
        prosButton.setTitleColor(.green, for: .normal)
        prosButton.contentVerticalAlignment = .center
        prosButton.layer.cornerRadius = buttonSize / 2
        prosButton.backgroundColor = .black  // delete

        consButton.setTitle("-", for: .normal)
        consButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 100)
        consButton.setTitleColor(.red, for: .normal)
        consButton.contentVerticalAlignment = .center
        consButton.layer.cornerRadius = buttonSize / 2
        consButton.backgroundColor = .black // delete
        consButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0) //replace


        view.addSubview(stitchesCount)
        view.addSubview(prosButton)
        view.addSubview(consButton)

        [stitchesCount, prosButton, consButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            stitchesCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stitchesCount.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),

            prosButton.centerYAnchor.constraint(equalTo: stitchesCount.centerYAnchor),
            prosButton.leadingAnchor.constraint(equalTo: stitchesCount.trailingAnchor, constant: 20),
            prosButton.widthAnchor.constraint(equalToConstant: buttonSize),
            prosButton.heightAnchor.constraint(equalToConstant: buttonSize),

            consButton.centerYAnchor.constraint(equalTo: prosButton.centerYAnchor),
            consButton.trailingAnchor.constraint(equalTo: stitchesCount.leadingAnchor, constant: -20),
            consButton.widthAnchor.constraint(equalToConstant: buttonSize),
            consButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }

    
    
    
    
    
    
    
}



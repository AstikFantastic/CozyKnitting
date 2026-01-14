import UIKit

protocol CounterViewProtocol: AnyObject {
    func updateCount(_ value: Int)
}

protocol CounterRouterProtocol{}

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
        
        presenter = CounterPresenter(view: self)
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {

        let buttonSize: CGFloat = 100
        
        let plusLongPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handlePlusLongPress(_:))
        )
        
        let minusLongPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleMinusLongPress(_:))
        )
        
        stitchesCount.textAlignment = .center
        stitchesCount.font = UIFont(name: "Arial Rounded MT Bold", size: 100)

        prosButton.setTitle("+", for: .normal)
        prosButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 100)
        prosButton.setTitleColor(.green, for: .normal)
        prosButton.contentVerticalAlignment = .center
        prosButton.layer.cornerRadius = buttonSize / 2
        prosButton.backgroundColor = .black  // delete
        prosButton.addTarget(self, action: #selector(plusOne), for: .touchUpInside)
        prosButton.addGestureRecognizer(plusLongPress)

        consButton.setTitle("-", for: .normal)
        consButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 100)
        consButton.setTitleColor(.red, for: .normal)
        consButton.contentVerticalAlignment = .center
        consButton.layer.cornerRadius = buttonSize / 2
        consButton.backgroundColor = .black // delete
        consButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0) //replace
        consButton.addTarget(self, action: #selector(minusOne), for: .touchUpInside)
        consButton.addGestureRecognizer(minusLongPress)

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
            prosButton.leadingAnchor.constraint(equalTo: stitchesCount.trailingAnchor, constant: 5),
            prosButton.widthAnchor.constraint(equalToConstant: buttonSize),
            prosButton.heightAnchor.constraint(equalToConstant: buttonSize),

            consButton.centerYAnchor.constraint(equalTo: prosButton.centerYAnchor),
            consButton.trailingAnchor.constraint(equalTo: stitchesCount.leadingAnchor, constant: -5),
            consButton.widthAnchor.constraint(equalToConstant: buttonSize),
            consButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
    }

    @objc private func plusOne() {
        presenter.didTapPlus()
    }
    
    @objc private func minusOne() {
        presenter.didTapMinus()
    }
    
    @objc private func handlePlusLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state{
        case .began:
            presenter.startIncrementing(.increment)
        case .ended, .cancelled:
            presenter.stopIncrementing()
        default:
            break
        }
    }
    
    @objc private func handleMinusLongPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state{
        case .began:
            presenter.startIncrementing(.decrement)
        case .ended, .cancelled:
            presenter.stopIncrementing()
        default:
            break
        }
    }
}

extension CounterViewController {
    func updateCount(_ value: Int) {
        stitchesCount.text = "\(value)"
    }
}


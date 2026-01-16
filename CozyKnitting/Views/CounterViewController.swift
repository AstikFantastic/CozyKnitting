import UIKit

protocol CounterViewProtocol: AnyObject {
    func updateCount(_ value: Int)
}

protocol CounterRouterProtocol {}

final class CounterViewController: UIViewController, CounterViewProtocol {
    
    private let stitchesCount = UILabel()
    private let prosButton = UIButton()
    private let consButton = UIButton()
    private let resetButton = UIButton.makeButton(
        title: "Reset",
        systemImage: "arrow.trianglehead.counterclockwise",
        foregroundColor: .black,
        backgroundColor: .red,
        textSize: 16
    )
    private let saveNewProjectButton = UIButton.makeButton(
        title: "Save as a new project",
        systemImage: "square.and.arrow.down.badge.checkmark.fill",
        foregroundColor: .black,
        backgroundColor: AppColors.buttonBackgroungColor,
        textSize: 16
    )
    private let addToCurrentButton = UIButton.makeButton(
        title: "Add to Current Project",
        systemImage: "checkmark.circle.badge.plus",
        foregroundColor: .black,
        backgroundColor: .green,
        textSize: 16
    )
    
    var presenter: CounterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        title = "Quick counter"
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
        stitchesCount.font = UIFont(name: "Arial Rounded MT Bold", size: 70)
        
        prosButton.setTitle("+", for: .normal)
        prosButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 70)
        prosButton.setTitleColor(.green, for: .normal)
        prosButton.contentVerticalAlignment = .center
        prosButton.layer.cornerRadius = buttonSize / 2
        prosButton.backgroundColor = .black  // delete
        prosButton.addTarget(self, action: #selector(plusOne), for: .touchUpInside)
        prosButton.addGestureRecognizer(plusLongPress)
        
        consButton.setTitle("-", for: .normal)
        consButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 70)
        consButton.setTitleColor(.red, for: .normal)
        consButton.contentVerticalAlignment = .center
        consButton.layer.cornerRadius = buttonSize / 2
        consButton.backgroundColor = .black // delete
        consButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0) //replace
        consButton.addTarget(self, action: #selector(minusOne), for: .touchUpInside)
        consButton.addGestureRecognizer(minusLongPress)
        
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        
        saveNewProjectButton.addTarget(self, action: #selector(saveAsNew), for: .touchUpInside)
        
        addToCurrentButton.addTarget(self, action: #selector(addToCurrent), for: .touchUpInside)
        
        view.addSubview(stitchesCount)
        view.addSubview(prosButton)
        view.addSubview(consButton)
        view.addSubview(resetButton)
        view.addSubview(saveNewProjectButton)
        view.addSubview(addToCurrentButton)
        
        [stitchesCount, prosButton, consButton, resetButton, saveNewProjectButton, addToCurrentButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stitchesCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stitchesCount.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            prosButton.centerYAnchor.constraint(equalTo: stitchesCount.centerYAnchor),
            prosButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            prosButton.widthAnchor.constraint(equalToConstant: buttonSize),
            prosButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            consButton.centerYAnchor.constraint(equalTo: prosButton.centerYAnchor),
            consButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            consButton.widthAnchor.constraint(equalToConstant: buttonSize),
            consButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            
            saveNewProjectButton.leadingAnchor.constraint(equalTo: resetButton.trailingAnchor, constant: 20),
            saveNewProjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveNewProjectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            saveNewProjectButton.heightAnchor.constraint(equalToConstant: 50),
            
            addToCurrentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToCurrentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToCurrentButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            addToCurrentButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func plusOne() {
        presenter.didTapPlus()
    }
    
    @objc private func minusOne() {
        presenter.didTapMinus()
    }
    
    @objc private func resetTapped() {
        resetButton.imageView?.addSymbolEffect(.rotate, options: .speed(10), animated: true)
        presenter.didTapReset()
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
    
    @objc private func saveAsNew() {
        saveNewProjectButton.imageView?.addSymbolEffect(.bounce, animated: true)
    }

    @objc private func addToCurrent() {
        addToCurrentButton.imageView?.addSymbolEffect(.breathe, options: .speed(5))
    }
}


// MARK: - Extensions

extension CounterViewController {
    func updateCount(_ value: Int) {
        stitchesCount.text = "\(value)"
    }
}

extension UIButton {
    static func makeButton(title: String, systemImage: String, foregroundColor: UIColor, backgroundColor: UIColor, textSize: CGFloat ) -> UIButton {
        
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(
            title,
            attributes: .init([
                .font: UIFont(name: "Arial Rounded MT Bold", size: textSize) ?? UIFont.self
            ])
        )
        
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .leading
        config.imagePadding = 5
        
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = foregroundColor
        config.cornerStyle = .capsule
        
        return UIButton(configuration: config)
    }
}


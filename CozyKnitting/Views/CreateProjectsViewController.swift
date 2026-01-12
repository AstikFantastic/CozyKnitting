import UIKit

protocol CreateProjectViewProtocol: AnyObject {
    func displaySelectedImage(_ image: UIImage)
    func showEmptyNameAlert()
    func showSizePicker()
    func updateSizeButtonTitle(_ title: String)
    
}

protocol CreateProjectsPresenterProtocol: AnyObject {
    func saveProject(name: String, image: UIImage)
}

final class CreateProjectsViewController: UIViewController, CreateProjectViewProtocol {
    
    private let header = UILabel()
    private let selectImageButton = UIButton()
    private let nameLabel = UILabel()
    private let projectNameTextField = UITextField()
    private let descriptionLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let descriptionPlaceholderLabel = UILabel()
    private let crochetButton = UIButton()
    private let needlesButton = UIButton()
    private var buttonsStack = UIStackView()
    private let pickerViewButton = UIButton()
    private let sizePickerView = UIPickerView()
    private let pickerContainerView = UIView()
    private let dimmedBackgroundView = UIView()
    private let sizeValues = ["0.5", "0.75", "0.875", "1", "1.25", "1.5", "2", "2.25", "2,5", "2.75", "3", "3.25", "3.5", "3.75", "4", "4.2", "4.5", "4.75", "5", "5.25", "5.5", "5.75", "6", "6.25", "6.5", "6.75", "7", "7.5", "8", "9", "10", "12", "16", "19", "20" ]
    private let saveButton = UIButton()
    
    private var presenter: CreateProjectPresenterProtocol!
    
    init(delegate: CreateProjectsDelegate) {
        super.init(nibName: nil, bundle: nil)
        let router = CreateProjectsRouter(viewControoller: self, delegate: delegate,)
        self.presenter = CreateProjectPresenter(view: self, router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.isTabBarHidden = true
        sizePickerView.delegate = self
        sizePickerView.dataSource = self
        setupUI()
        setupPickerViewUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.isTabBarHidden = false
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = AppColors.backgroundColor
        
        header.text = "Start a new project"
        header.font = UIFont(name: "Helvetica-Bold", size: 30)
        header.textColor = .black
        view.addSubview(header)
        
        selectImageButton.setImage(UIImage(named: "emptyProjectImage"), for: .normal)
        selectImageButton.backgroundColor = AppColors.backgroundColor
        selectImageButton.tintColor = .black
        selectImageButton.clipsToBounds = true
        selectImageButton.layer.cornerRadius = 12
        selectImageButton.addTarget(self, action: #selector(chooseImageButtonTapped), for: .touchUpInside)
        view.addSubview(selectImageButton)
        
        nameLabel.text = "Name"
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        view.addSubview(nameLabel)
        
        projectNameTextField.placeholder = "Project name"
        projectNameTextField.borderStyle = .roundedRect
        projectNameTextField.backgroundColor = AppColors.backgroundColor
        view.addSubview(projectNameTextField)
        
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        view.addSubview(descriptionLabel)
        
        descriptionTextView.delegate = self
        descriptionTextView.backgroundColor = AppColors.backgroundColor
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textColor = .black
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        view.addSubview(descriptionTextView)
        
        descriptionPlaceholderLabel.text = "Enter a project description"
        descriptionPlaceholderLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionPlaceholderLabel.textColor = .lightGray
        descriptionTextView.addSubview(descriptionPlaceholderLabel)
        
        crochetButton.configuration = makeButtonConfiguration(title: "🪡 Crochet")
        crochetButton.addTarget(self, action: #selector(crochetTapped), for: .touchUpInside)
        
        needlesButton.configuration = makeButtonConfiguration(title: "🧶 Spokes")
        needlesButton.addTarget(self, action: #selector(needlesTapped), for: .touchUpInside)
        
        buttonsStack = UIStackView(arrangedSubviews: [crochetButton, needlesButton])
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .center
        buttonsStack.distribution = .fillEqually
        view.addSubview(buttonsStack)
        
        pickerViewButton.configuration = makeButtonConfiguration(title: "Size: ")
        pickerViewButton.configuration?.baseBackgroundColor = AppColors.buttonBackgroungColor
        pickerViewButton.configuration?.baseForegroundColor = .white
        pickerViewButton.addTarget(self, action: #selector(sizeButtonTapped), for: .touchUpInside)
        view.addSubview(pickerViewButton)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = AppColors.buttonBackgroungColor
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        
        [header, selectImageButton, nameLabel, projectNameTextField, descriptionLabel, descriptionTextView, descriptionPlaceholderLabel, buttonsStack, pickerViewButton, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            selectImageButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 25),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            selectImageButton.widthAnchor.constraint(equalToConstant: 75),
            selectImageButton.heightAnchor.constraint(equalToConstant: 75),
            
            nameLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: selectImageButton.trailingAnchor, constant: 15),
            
            projectNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            projectNameTextField.leadingAnchor.constraint(equalTo: selectImageButton.trailingAnchor, constant: 15),
            projectNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            projectNameTextField.heightAnchor.constraint(equalToConstant: 51),
            
            descriptionLabel.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 8),
            
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            buttonsStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            pickerViewButton.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 10),
            pickerViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup PickerView
    
    private func setupPickerViewUI() {
        dimmedBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmedBackgroundView.alpha = 0
        dimmedBackgroundView.frame = view.bounds
        dimmedBackgroundView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPickerView))
        dimmedBackgroundView.addGestureRecognizer(tapGesture)
        view.addSubview(dimmedBackgroundView)
        
        pickerContainerView.backgroundColor = AppColors.backgroundColor
        pickerContainerView.layer.cornerRadius = 12
        pickerContainerView.clipsToBounds = true
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerContainerView)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = AppColors.buttonBackgroungColor
        toolbar.isTranslucent = false
        toolbar.tintColor = .white
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        sizePickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.addSubview(toolbar)
        pickerContainerView.addSubview(sizePickerView)
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300), // Start off-screen
            pickerContainerView.heightAnchor.constraint(equalToConstant: 250),
            
            toolbar.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            
            sizePickerView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            sizePickerView.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            sizePickerView.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            sizePickerView.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor)
        ])
    }
    
    
    
    // MARK: - View Protocol Methods
    
    func displaySelectedImage(_ image: UIImage) {
        selectImageButton.setImage(image, for: .normal)
    }
    
    func showEmptyNameAlert() {
        let alert = UIAlertController(title: "Error", message: "Enter a project name", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSizePicker() {
        dimmedBackgroundView.isHidden = false
        dimmedBackgroundView.alpha = 0
        pickerContainerView.transform = .identity
        UIView.animate(withDuration: 0.3) {
            self.dimmedBackgroundView.alpha = 1
            self.pickerContainerView.transform = CGAffineTransform(translationX: 0, y: -250)
        }
    }
    
    func updateSizeButtonTitle(_ title: String) {
        pickerViewButton.setTitle(title, for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func chooseImageButtonTapped() {
        presenter.didTapSelectImage()
    }
    
    @objc private func saveButtonTapped() {
        let name = projectNameTextField.text ?? ""
        let image = selectImageButton.image(for: .normal) ?? UIImage(named: "emptyProjectImage")!
        presenter.saveProject(name: name, image: image)
    }
    
    func makeButtonConfiguration(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .gray
        return config
    }
    
    func selectButton(_ button: UIButton) {
        var config = button.configuration!
        config.baseBackgroundColor = AppColors.buttonBackgroungColor
        config.baseForegroundColor = .white
        button.configuration = config
    }
    
    func deselectButton(_ button: UIButton) {
        var config = button.configuration!
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .gray
        button.configuration = config
    }
    
    @objc func crochetTapped() {
        selectButton(crochetButton)
        deselectButton(needlesButton)
    }
    
    @objc func needlesTapped() {
        selectButton(needlesButton)
        deselectButton(crochetButton)
    }
    
    @objc func sizeButtonTapped() {
        presenter.didTapSizeButton()
    }
    
    @objc func doneButtonTapped() {
        let selectedSize = sizeValues[sizePickerView.selectedRow(inComponent: 0)]
        presenter.didSelectSize(selectedSize)
        dismissPickerView()
    }
    
    @objc func dismissPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dimmedBackgroundView.alpha = 0
            self.pickerContainerView.transform = .identity
        }, completion: { _ in
            self.dimmedBackgroundView.isHidden = true
        })
    }
    
}


    // MARK: - Text View Delegate

extension CreateProjectsViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholderLabel.isHidden = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

    // MARK: - PickerViewDataSource, PickerViewDelegate

extension CreateProjectsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeValues[row]
    }
    
}

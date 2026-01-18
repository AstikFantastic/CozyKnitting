import UIKit

protocol CreateProjectViewProtocol: AnyObject {
    func displaySelectedImage(_ image: UIImage)
    func showEmptyNameAlert()

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
        setupUI()

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
               
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = AppColors.buttonBackgroungColor
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 12
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        
        [header, selectImageButton, nameLabel, projectNameTextField, descriptionLabel, descriptionTextView, descriptionPlaceholderLabel, /*buttonsStack, pickerViewButton, */saveButton].forEach {
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
                        
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
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
}


    // MARK: - Text View Delegate

extension CreateProjectsViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionPlaceholderLabel.isHidden = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

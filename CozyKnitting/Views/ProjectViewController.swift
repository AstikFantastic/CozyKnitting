import UIKit

protocol ProjectsViewProtocol: AnyObject {}

protocol ProjectsPresenterProtocol {
    func didTapNewProjectButton(from view: UIViewController)
}

final class ProjectsViewController: UIViewController, ProjectsViewProtocol {
    
    var presenter: ProjectsPresenterProtocol!
    
    var collectionView: UICollectionView!
    
    var userProjects: [ProjectsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        navigationItem.title = "Projects"
        
        
        
        setupCollectionProjectsView()
        setupNewProjectButton()
        
    }
    
    private func setupCollectionProjectsView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 173, height: 242)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = .init(top: 25, left: 25, bottom: 25, right: 25)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: "ProjectsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNewProjectButton() {
        
        let newProjectButtom = UIButton()
        newProjectButtom.setImage(UIImage(systemName: "plus"), for: .normal)
        newProjectButtom.tintColor = .white
        newProjectButtom.backgroundColor = AppColors.buttonBackgroungColor
        newProjectButtom.layer.cornerRadius = 25
        newProjectButtom.clipsToBounds = true
        newProjectButtom.translatesAutoresizingMaskIntoConstraints = false
        newProjectButtom.addTarget(self, action: #selector(didTapNewProjectButton), for: .touchUpInside)
        
        view.addSubview(newProjectButtom)
        view.bringSubviewToFront(newProjectButtom)
        
        NSLayoutConstraint.activate([
            newProjectButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            newProjectButtom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            newProjectButtom.widthAnchor.constraint(equalToConstant: 50),
            newProjectButtom.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func didTapNewProjectButton() {
        presenter.didTapNewProjectButton(from: self)
    }
}

// MARK: - UICollectioViewDelegate, UICollectioViewDataSourse

extension ProjectsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectsCollectionViewCell", for: indexPath) as! ProjectsCollectionViewCell
        let userProjects = userProjects[indexPath.item]
        cell.imageView.image = userProjects.image
        cell.nameLabel.text = userProjects.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print()
    }
}

// MARK: - CreateProjectDelegate

extension ProjectsViewController: CreateProjectsDelegate {
    func didCreateNewProject(_ project: ProjectsModel) {
        userProjects.append(project)
        collectionView.reloadData()
    }
}


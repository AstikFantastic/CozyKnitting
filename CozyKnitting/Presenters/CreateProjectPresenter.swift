import UIKit

protocol CreateProjectPresenterProtocol: AnyObject {
    func didTapSelectImage()
    func didSelectImage(_ image: UIImage?)
    func saveProject(name: String, image: UIImage)

}

final class CreateProjectPresenter: CreateProjectPresenterProtocol {

    weak var view: CreateProjectsViewProtocol?
    let router: CreateProjectsRouterProtocol

    init(view: CreateProjectsViewProtocol, router: CreateProjectsRouterProtocol) {
        self.view = view
        self.router = router
    }

    func didTapSelectImage() {
        router.showImagePicker { [weak self] image in
            self?.view?.displaySelectedImage(image)
        }
    }

    func didSelectImage(_ image: UIImage?) {
        guard let image = image else { return }
        view?.displaySelectedImage(image)
    }
    
    func saveProject(name: String, image: UIImage) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            view?.showEmptyNameAlert()
            return
        }
        
        let newProject = ProjectsModel(name: name, image: image)
        router.closeAndReturnToProjects(with: newProject)
    }
    
    
}

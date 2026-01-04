import UIKit

protocol CreateProjectPresenterProtocol: AnyObject {
    func didTapSelectImage()
    func didSelectImage(_ image: UIImage?)
    func saveProject(name: String, image: UIImage)
    func didTapSizeButton()
    func didSelectSize(_ size: String)
}

final class CreateProjectPresenter: CreateProjectPresenterProtocol {
    weak var view: CreateProjectViewProtocol?
    let router: CreateProjectsRouterProtocol

    init(view: CreateProjectViewProtocol, router: CreateProjectsRouterProtocol) {
        self.view = view
        self.router = router
    }

    func didTapSelectImage() {
        view?.showImagePicker()
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
    
    func didTapSizeButton() {
        view?.showSizePicker()
    }
    
    func didSelectSize(_ size: String) {
        view?.updateSizeButtonTitle("Size: \(size)")

    }
    
}

import UIKit

protocol CreateProjectsRouterProtocol: AnyObject {
    func closeAndReturnToProjects(with project: ProjectsModel)
    func showImagePicker(completion: @escaping (UIImage) -> Void)
}

final class CreateProjectsRouter: CreateProjectsRouterProtocol {
    
    private weak var viewController: UIViewController?
    weak var delegate: CreateProjectsDelegate?
    private let imagePicker: ImagePickerViewController
    
    
    init(viewControoller: UIViewController, delegate: CreateProjectsDelegate) {
        self.viewController = viewControoller
        self.delegate = delegate
        self.imagePicker = ImagePickerViewController(presentationController: viewControoller)
    }

    func closeAndReturnToProjects(with project: ProjectsModel) {
        delegate?.didCreateNewProject(project)
        
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        imagePicker.presentImagePicker { image in
            completion(image)
        }
    }
}

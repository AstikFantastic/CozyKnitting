import UIKit

protocol CreateProjectsRouterProtocol: AnyObject {
    func closeAndReturnToProjects(with project: ProjectsModel)
}

final class CreateProjectsRouter: CreateProjectsRouterProtocol {
    weak var viewController: UIViewController?
    weak var delegate: CreateProjectsDelegate?
    
    init(viewControoller: UIViewController, delegate: CreateProjectsDelegate) {
        self.viewController = viewControoller
        self.delegate = delegate
    }

    func closeAndReturnToProjects(with project: ProjectsModel) {
        delegate?.didCreateNewProject(project)
        
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
}

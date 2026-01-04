import UIKit

final class ProjectsPresenter: ProjectsPresenterProtocol {
    
    weak var view: ProjectsViewProtocol?
    let router: ProjectsRouterProtocol
    
    init(view: ProjectsViewProtocol, router: ProjectsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func didTapNewProjectButton(from view: UIViewController) {
        router.openCreateNewProjectVC(from: view)
    }
    
}

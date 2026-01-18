import UIKit

protocol ProjectsRouterProtocol {
    func openCreateNewProjectVC(from view: UIViewController)
}

final class ProjectsRouter: ProjectsRouterProtocol {
    static func createModule() -> UIViewController {
        let view = ProjectsViewController()
        let router = ProjectsRouter()
        let presenter = ProjectsPresenter(view: view, router: router)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(title: "Projects", image: UIImage(systemName: "folder"), tag: 0)
        return UINavigationController(rootViewController: view)
    }
    
    func openCreateNewProjectVC(from view: UIViewController) {
        guard let projectsVC = view as? CreateProjectsDelegate else { return }
        let createNewProjectVC = CreateProjectsViewController(delegate: projectsVC)
        view.present(createNewProjectVC, animated: true)
    }
    
}

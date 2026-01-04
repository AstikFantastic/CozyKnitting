import UIKit

final class ProfileRouter: ProfileRouterProtocol {
    static func createModule() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        return UINavigationController(rootViewController: view)
    }
}

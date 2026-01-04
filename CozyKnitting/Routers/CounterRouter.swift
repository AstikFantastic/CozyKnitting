import UIKit

final class CounterRouter: CounterRouterProtocol {
    static func createModule() -> UIViewController {
        let view = CounterViewController()
        let router = CounterRouter()
        let presenter = CounterPresenter(view: view, router: router)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(title: "Counter", image: UIImage(systemName: "5.arrow.trianglehead.counterclockwise"), tag: 1)
        return UINavigationController(rootViewController: view)
    }
}

import UIKit

final class MainTabBarRouter {
    
    static func createTabBarModule() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            ProjectsRouter.createModule(),
            CounterRouter.createModule(),
            ProfileRouter.createModule()
        ]
        return tabBar
    }
}

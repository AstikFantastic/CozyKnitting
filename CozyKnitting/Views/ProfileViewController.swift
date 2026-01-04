import UIKit

protocol ProfileViewProtocol: AnyObject {}
protocol ProfilePresenterProtocol {
    
}
protocol ProfileRouterProtocol {}

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        title = "Profile"
    }
}

import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    let router: ProfileRouterProtocol

    init(view: ProfileViewProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {}
}

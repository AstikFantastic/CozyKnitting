import UIKit

final class CounterPresenter: CounterPresenterProtocol {
    weak var view: CounterViewProtocol?
    let router: CounterRouterProtocol

    init(view: CounterViewProtocol, router: CounterRouterProtocol) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {}
}

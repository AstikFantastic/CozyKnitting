import UIKit

protocol CounterViewProtocol: AnyObject {}
protocol CounterPresenterProtocol {

}
protocol CounterRouterProtocol {}

final class CounterViewController: UIViewController, CounterViewProtocol {
    var presenter: CounterPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        title = "Counter"
    }
}

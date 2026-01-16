import UIKit

protocol CounterPresenterProtocol {
    func viewDidLoad()
    func didTapPlus()
    func didTapMinus()
    func didTapReset()
    func startIncrementing(_ direction: CounterDirection)
    func stopIncrementing()
    
    func shouldShowResetAlert() -> Bool
    func setNeverShowResetAlert(_ value: Bool)
    func handleResetTap()
}

enum CounterDirection {
    case increment
    case decrement
}

final class CounterPresenter: CounterPresenterProtocol {
    
    weak var view: CounterViewProtocol?
    
    private let neverShowKey = "neverShowResetAlert"
    
    
    func shouldShowResetAlert() -> Bool {
           !UserDefaults.standard.bool(forKey: neverShowKey)
       }

       func setNeverShowResetAlert(_ value: Bool) {
           UserDefaults.standard.set(value, forKey: neverShowKey)
       }
    
    private var count: Int = 0 {
        didSet {
            view?.updateCount(count)
        }
    }
    
    private var timer: Timer?
    private var direction: CounterDirection?
    private var minValue = 0
    private var maxValue = 999
    private func changeCount(by delta: Int) {
        let newValue = count + delta
        let stopValue = min(max(newValue, minValue), maxValue)
        if stopValue == count {
            stopIncrementing()
            return
        }
        
        count = stopValue
    }
    
    init(view: CounterViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        view?.updateCount(count)
    }
    
    func didTapPlus() {
        changeCount(by: 1)
    }
    
    func didTapMinus() {
        changeCount(by: -1)
    }
    
    func didTapReset() {
        view?.animateReset()
        count = 0
    }
    
    func handleResetTap() {
        if shouldShowResetAlert() {
            view?.showResetAlert()
        } else {
            didTapReset()
        }
    }

    func startIncrementing(_ direction: CounterDirection) {
        self.direction = direction
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            switch self.direction {
            case .increment:
                self.changeCount(by: 1)
            case .decrement:
                self.changeCount(by: -1)
            case .none:
                break
            }
        }
    }
    
    func stopIncrementing() {
        timer?.invalidate()
        timer = nil
        direction = nil
    }
}

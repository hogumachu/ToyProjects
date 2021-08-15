import RxSwift

class MainViewModel {
    func appear(_ label: UILabel, duration: TimeInterval) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            label.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                label.textColor = .white
                label.alpha = 1
            }, completion: { _ in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}

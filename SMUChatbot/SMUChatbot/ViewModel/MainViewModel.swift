import UIKit

class MainViewModel {
    func viewAnimate(_ vc: MainViewController) {
        var timeInterval = 0.5
        let labels = [vc.smuLabel, vc.capstoneLabel, vc.teamNameLabel]
        
        labels.forEach { label in
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
                UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve) {
                    label.textColor = .white
                }
            }
            timeInterval += 0.5
        }
    }
}

import UIKit

class InfoViewModel {
    func gotoChatVC(_ vc: UIViewController) {
        guard let navigationVC = vc.navigationController else {
            print(#function, "NavigationController Error")
            return
        }
        
        let chatVC = ChatViewController(viewModel: ChatViewModel())
        chatVC.modalTransitionStyle = .flipHorizontal
        chatVC.modalPresentationStyle = .fullScreen
        navigationVC.pushViewController(chatVC, animated: true)
    }
}

import UIKit
import RxSwift
import SnapKit

class InfoDetailUseViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    let info: Info
    
    init(dependency: Dependency, payload: ()) {
        self.info = dependency.info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

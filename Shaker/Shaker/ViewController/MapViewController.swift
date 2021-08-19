import UIKit
import NMapsMap

class MapViewController: BaseViewController {
    
    override func viewDidLoad() {
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
}

import UIKit


class Assembly {
   static func makeViewController() -> UIViewController {
        let vc = ViewController()
        let network = NetworkDataManager()
        let presenter = MainViewPresenter(network: network, view: vc)
        vc.presenter = presenter
        
        return vc
    }
}

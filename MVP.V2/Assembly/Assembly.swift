import UIKit


class Assembly {
   static func makeViewController() -> UIViewController {
        let vc = ViewController()
        let network = NetworkDataManager()
        let presenter = MainViewPresenter(network: network, view: vc)
        vc.presenter = presenter
        
        return vc
    }
    
    static func makeDetailsViewController(itemPhoto: API.Photo) -> UIViewController {
        let vc = DetailsViewController()
        let presenter = DetailsViewPresenter(itemPhoto: itemPhoto, view: vc)
        vc.presenter = presenter
        return vc
    }
}

import UIKit


class Assembly {
    static func makeViewController() -> UIViewController {
        let mainViewController = ViewController()
        let network = NetworkDataManager()
        let presenter = MainViewPresenter(view: mainViewController, network: network)
        mainViewController.presenter = presenter
        
        return mainViewController
    }
}

import UIKit


protocol ViewControllerProtocol: AnyObject {
    func updateImages()
}

class ViewController: UIViewController, ViewControllerProtocol {
    var presenter: MainViewPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateImages() {
       
    }
}


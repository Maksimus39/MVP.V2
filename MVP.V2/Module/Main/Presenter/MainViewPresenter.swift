import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    func fetchImageData()
    var images: [API.Photo] { get }
}


final class MainViewPresenter: MainViewPresenterProtocol {
    private(set) var images: [API.Photo] = []
    private var img: [API.Photo] = []
    private let network: NetworkDataManagerProtocol
    private weak var view: ViewControllerProtocol?
    
    init(network: NetworkDataManagerProtocol, view: ViewControllerProtocol?) {
        self.network = network
        self.view = view
    }
    
    func fetchImageData() {
        network.requestData { [weak self] (res: Result<[API.Photo], Error>) in
            DispatchQueue.main.async {
                switch res {
                case .success(let loadImages):
                    print("мы получили данные")
                    self?.images = loadImages
                    self?.view?.updateImages()
                    
                case .failure(let error):
                    print("мы не получили данные")
                    print(error)
                }
            }
        }
    }
}

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    func getPhotoData()
    var photoData: [API.Photo] { get }
}

class MainViewPresenter: MainViewPresenterProtocol {
    weak var view: ViewControllerProtocol?
    let network: NetworkDataManagerProtocol
    
    // DI <- инъекция зависимостей
    var photoData: [API.Photo] = []
    
    init(view: ViewControllerProtocol? = nil, network: NetworkDataManagerProtocol) {
        self.view = view
        self.network = network
    }
    
    func getPhotoData() {
        network.requestData { [weak self] (res: Result<[API.Photo], Error>) in
            guard let self else { return }
            switch res {
            case .success(let success):
                DispatchQueue.main.async {
                    self.photoData = success
                    self.view?.updateTable()
                }
              
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

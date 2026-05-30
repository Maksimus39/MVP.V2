import Foundation


protocol DetailsViewPresenterProtocol: AnyObject {
    var itemPhoto: API.Photo { get }
}


class DetailsViewPresenter: DetailsViewPresenterProtocol {
    var itemPhoto: API.Photo
    weak var view: DetailsViewControllerProtocol!
    
    init(itemPhoto: API.Photo, view: DetailsViewControllerProtocol!) {
        self.itemPhoto = itemPhoto
        self.view = view
    }
}

import Foundation
import Alamofire


protocol NetworkDataManagerProtocol: AnyObject {
    func requestData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkDataManager {
    
}


// "https://jsonplaceholder.typicode.com/photos"
//[
//    {
//    "albumId": 1,
//    "id": 1,
//    "title": "accusamus beatae ad facilis cum similique qui sunt",
//    "url": "https://via.placeholder.com/600/92c952",
//    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//}
//]

// MARK: - Модель для одного элемента
struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// Ваш ответ от сервера - это массив, поэтому используем [Photo]
typealias PhotosResponse = [Photo]




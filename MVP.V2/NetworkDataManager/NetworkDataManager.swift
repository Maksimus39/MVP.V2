import Foundation
import Alamofire


protocol NetworkDataManagerProtocol: AnyObject {
    func requestData<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void)
}

class NetworkDataManager: NetworkDataManagerProtocol {
    func requestData<T>(completion: @escaping (Result<[T], any Error>) -> Void) where T : Decodable {
        
        guard let url = URL(string: API.Endpoint.photos.fullURL()) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let params: Parameters? = nil
        AF.request(url, parameters: params)
            .validate(statusCode: 200..<300)
            .response { res in
                // error
                guard res.error == nil else {
                    completion(.failure(res.error!))
                    return
                }
                
                // data
                guard let data = res.data else {
                    completion(.failure(URLError(.dataNotAllowed)))
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode([T].self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}

import Foundation

struct API {
    static let baseURL = "https://picsum.photos"
    
    enum Endpoint {
        case photos(page: Int = 1, limit: Int = 500)
        
        var path: String {
            switch self {
            case .photos:
                return "/v2/list"
            }
        }
        
        func fullURL() -> String {
            switch self {
            case .photos(let page, let limit):
                return API.baseURL + path + "?page=\(page)&limit=\(limit)"
            }
        }
    }
    
    struct Photo: Decodable {
        let id: String
        let author: String
        let download_url: String
    }
}

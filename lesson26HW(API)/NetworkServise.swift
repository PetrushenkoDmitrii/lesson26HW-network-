import Alamofire
import Foundation


final class NetworkServise {
     
    enum NetworkError: Error {
        case invalidURL
        case clientError
        case serverError
        case decodingError

        var description: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .clientError:
                return "Client error"
            case .serverError:
                return "Server error"
            case .decodingError:
                return "Decoding error"
            }
        }
    }
    
    
    func fetchUserAF(completion: @escaping (Result<[UserModel], NetworkError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/users",
                   method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [UserModel].self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure:
                    completion(.failure(.serverError))
                }
            }
    }
}

struct UserModel: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Adress
    let phone: String
    let website: String
    let company: Company
    
    struct Adress: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
    }
    
    struct Geo: Decodable {
        let lat: String
        let lng: String
    }
    
    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

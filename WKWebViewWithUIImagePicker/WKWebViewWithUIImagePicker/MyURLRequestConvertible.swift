import Foundation
import Alamofire

struct MyURLRequestConvertible: URLRequestConvertible {
    let urlString: String
    
    func asURLRequest() throws -> URLRequest {
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
}

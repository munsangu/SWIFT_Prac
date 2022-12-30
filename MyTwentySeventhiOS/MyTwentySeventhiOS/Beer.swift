import Foundation

struct Beer: Decodable {
    let id: Int?
    let name, taglineString, description, brewersTips, imageURL: String?
    let foodPairing: [String]?
    
    var tagLine: String {
        guard let taglineString = taglineString else { return ""}
        let hashtag = "#\(taglineString)"
        return hashtag
    }
    
    // 변수명과 실제로 받는 key의 이름들을 동일하게 하기 위함
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case taglineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodPairing = "food_pairing"
    }
}

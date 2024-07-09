import Foundation

struct FighterResponse: Decodable {
    let id: Int?
    let name: String?
    let nickname: String?
    let photo: String?
    let gender: String?
    let birthDate: String?
    let age: Int?
    let height: String?
    let weight: String?
    let reach: String?
    let stance: String?
    let category: String?
    let team: Team?
    let lastUpdate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, nickname, photo, gender
        case birthDate = "birth_date"
        case age, height, weight, reach, stance, category, team
        case lastUpdate = "last_update"
    }
}

struct Team: Decodable {
    let id: Int?
    let name: String?
}

struct FightersResponse: Decodable {
    let response: [FighterResponse]
}

struct WeightClassesResponse: Decodable {
    let response: [String]
}

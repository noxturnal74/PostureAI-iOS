import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    let email: String
    let displayName: String
    let avatarURL: String?
    let age: Int?
    let gender: Gender?
    let fitnessLevel: FitnessLevel
    let createdAt: Date
    
    enum Gender: String, Codable {
        case male = \"male\"
        case female = \"female\"
        case other = \"other\"
        case preferNotToSay = \"prefer_not_to_say\"
    }
    
    enum FitnessLevel: String, Codable {
        case beginner = \"beginner\"
        case intermediate = \"intermediate\"
        case advanced = \"advanced\"
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

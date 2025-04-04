

import UIKit

public struct UserCreateInfo: Codable {
    let id: String
    let appleToken: String
    let pushToken: String
    let createdAt: String
    let isPro: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case appleToken = "auth_token"
        case pushToken = "push_token"
        case createdAt = "created_at"
        case isPro = "is_pro"
    }
}

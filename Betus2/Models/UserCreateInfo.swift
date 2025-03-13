

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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        appleToken = try container.decode(String.self, forKey: .appleToken)
        pushToken = try container.decode(String.self, forKey: .pushToken)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        isPro = try container.decodeIfPresent(Bool.self, forKey: .isPro) ?? false 
    }
}

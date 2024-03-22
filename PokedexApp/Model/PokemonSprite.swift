import Foundation

struct PokemonSprite: Decodable {
    let frontDefault: String
}

extension PokemonSprite {
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

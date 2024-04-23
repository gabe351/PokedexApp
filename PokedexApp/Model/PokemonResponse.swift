import Foundation

struct PokemonResponse: Decodable {
    let name: String
    let url: String
    let spriteURL: String?
    let isFavorite: Bool?

    init(
        name: String,
        url: String,
        spriteURL: String? = nil,
        isFavorite: Bool? = false
    ) {
        self.name = name
        self.url = url
        self.spriteURL = spriteURL
        self.isFavorite = isFavorite
    }
}

import Foundation

struct PokemonData: Decodable {
    let id: Int
    let order: Int
    let name: String
    let sprites: PokemonSprite
    let moves: [BaseMoveResponse]
    let isFavorite: Bool?

    init(
        id: Int,
        order: Int,
        name: String,
        sprites: PokemonSprite,
        moves: [BaseMoveResponse],
        isFavorite: Bool? = false
    ) {
        self.id = id
        self.order = order
        self.name = name
        self.sprites = sprites
        self.moves = moves
        self.isFavorite = isFavorite
    }
}

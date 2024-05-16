import Foundation

struct PokemonData: Decodable {
    let id: Int
    let order: Int
    let name: String
    let sprites: PokemonSprite
    let moves: [BaseMoveResponse]
    let types: [PokemonTypeResponse]
    let isFavorite: Bool?

    var mainType: String {
        types.first?.type.name ?? "Unkown"
    }

    init(
        id: Int,
        order: Int,
        name: String,
        sprites: PokemonSprite,
        moves: [BaseMoveResponse],
        types: [PokemonTypeResponse],
        isFavorite: Bool? = false
    ) {
        self.id = id
        self.order = order
        self.name = name
        self.sprites = sprites
        self.moves = moves
        self.types = types
        self.isFavorite = isFavorite
    }
}

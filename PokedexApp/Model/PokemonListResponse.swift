import Foundation

struct PokemonListBaseResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResponse]?
}

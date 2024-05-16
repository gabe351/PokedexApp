import Foundation

struct PokemonTypeResponse: Decodable {
    let slot: Int
    let type: PokemonTypeDetailResponse
}

struct PokemonTypeDetailResponse: Decodable {
    let name: String
}

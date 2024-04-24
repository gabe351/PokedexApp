import Foundation

struct PokedexDto {
    let count: Int?
    var next: String?
    let previous: String?
    var pokemonList: [PokemonData]

    init(
        data: PokemonListBaseResponse,
        pokemonList: [PokemonData]
    ) {

        self.count = data.count
        self.next = data.next
        self.previous = data.previous
        self.pokemonList = pokemonList
    }
}

//
//  PokemonDetailView.swift
//  PokedexApp
//
//  Created by Gabriel Rosa on 4/24/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonData

    init(pokemon: PokemonData) {
        self.pokemon = pokemon
    }

    var body: some View {
        VStack {
            Text("Detail View")
                .font(.largeTitle)

            Text(pokemon.name)
                .padding()
        }

    }
}

#Preview {
    PokemonDetailView(
        pokemon: PokemonData(
            id: 1,
            order: 1,
            name: "bulbasaur",
            sprites: PokemonSprite(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"
            ),
            moves: [],
            types: [
                PokemonTypeResponse(
                    slot: 1,
                    type: .init(name: "grass")
                )
            ],
            isFavorite: true
        )
    )
}

import SwiftUI

struct PokemonCellView: View {

    @Binding var toast: Toast?
    private let pokemon: PokemonData

    var typeColor: Color {
        PokemonTypeColors.getColor(pokemon.mainType)
    }

    init(toast: Binding<Toast?>,
         pokemon: PokemonData
    ) {
        self._toast = toast
        self.pokemon = pokemon
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundStyle(
                    typeColor
                    .opacity(0.2)
                )
                .frame(width: 180, height: 90)

            VStack(spacing: 0.0) {
                AsyncImage(
                    url: URL(string: pokemon.sprites.frontDefault),
                    content: { image in
                        image
                            .resizable()
                            .frame(width: 60, height: 60)
                    },
                    placeholder: {
                        ProgressView()
                            .tint(.yellow)
                            .frame(width: 40, height: 60)
                    }
                )

                Text(pokemon.name.capitalizingFirstLetter())
                    .font(.title3)
                    .foregroundStyle(typeColor)
                .padding(.horizontal, 8)
                .padding(.bottom, 4)

                HStack {
                    Text(pokemon.mainType)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundStyle(
                                    typeColor
                                        .opacity(0.5)
                                )
                        }

                    Image(pokemon.isFavorite == true ? .pokeballRed : .pokeballGray)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            var isFavorite = pokemon.isFavorite ?? false
                            handleTap(isFavorite)
                        }
                }
            }
            .offset(y: -25)
        }
    }

    func handleTap(_ favorite: Bool) {
        if favorite {
            self.toast = Toast(
                style: .info,
                message: Strings.alreadySaved.text
            )
        } else {
            // TODO: Integrate to save in database and then toast
            self.toast = Toast(
                style: .success,
                message: Strings.savedSuccess.text
            )
        }
    }
}

#Preview("Pokemon with pic and type") {
    PokemonCellView(
        toast: .constant(.init(style: .success, message: "Saved success")),
        pokemon: 
            PokemonData(
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

#Preview("Pokemon without type") {
    PokemonCellView(
        toast: .constant(.init(style: .success, message: "Saved success")),
        pokemon:
            PokemonData(
                id: 1,
                order: 1,
                name: "bulbasaur",
                sprites: PokemonSprite(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"
                ),
                moves: [],
                types: [],
                isFavorite: false
            )
    )
}

#Preview("Pokemon without pic and type") {
    PokemonCellView(
        toast: .constant(.init(style: .success, message: "Saved success")),
        pokemon:
            PokemonData(
                id: 1,
                order: 1,
                name: "bulbasaur",
                sprites: PokemonSprite(
                    frontDefault: ""
                ),
                moves: [],
                types: [],
                isFavorite: true
            )
    )
}

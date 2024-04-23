import SwiftUI

extension MVVM {
    struct PokemonListView: View {
        @ObservedObject var viewModel: PokemonListViewModel
        @Binding var toast: Toast?

        init(
            viewModel: PokemonListViewModel,
            toast: Binding<Toast?>
        ) {
            self.viewModel = viewModel
            self._toast = toast
        }

        var body: some View {
            VStack {
                AsyncContentView(source: viewModel) { pokemonList in
                    ContentView(pokemonList: pokemonList, toast: $toast)
                }
            }
            .onAppear(perform: {
                viewModel.fetchList()
            })
        }
    }
}

extension MVVM.PokemonListView {
    struct ContentView: View {

        @Binding var toast: Toast?
        private let pokemonList: [PokemonData]

        init(
            pokemonList: [PokemonData],
            toast: Binding<Toast?>
        ) {
            self.pokemonList = pokemonList
            self._toast = toast
        }

        var body: some View {
            List(pokemonList, id: \.id) { pokemon in
                HStack {
                    AsyncImage(
                        url: URL(string: pokemon.sprites.frontDefault),
                        content: { image in
                            image.resizable()
                        },
                        placeholder: {
                            ProgressView()
                                .tint(.yellow)
                        }
                    )
                    .frame(width: 64, height: 64)
                    .background {
                        Color.gray
                            .opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }


                    Text(pokemon.name.capitalizingFirstLetter())
                        .padding(.horizontal)
                        .font(.title3)

                    Spacer()

                    Image(pokemon.isFavorite == true ? .pokeballRed : .pokeballGray)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            handleTap(pokemon.isFavorite ?? false)
                        }
                }
                .listRowSeparator(.hidden)

            }
        }

        func handleTap(_ favorite: Bool) {
            if favorite {
                self.toast = Toast(
                    style: .info,
                    message: Strings.alreadySaved.text
                )
            } else {
                self.toast = Toast(
                    style: .success,
                    message: Strings.savedSuccess.text
                )
            }
        }
    }
}

#Preview {
    MVVM.PokemonListView(viewModel: .init(), toast: .constant(.init(
        style: .success,
        message: "Saved"
    )))
}

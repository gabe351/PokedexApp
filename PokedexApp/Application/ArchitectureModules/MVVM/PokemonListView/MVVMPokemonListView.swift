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
                AsyncContentView(source: viewModel) { pokedex in
                    ContentView(pokemonList: pokedex.pokemonList, toast: $toast) { id in
                        viewModel.fetchNextPageIfNeeded(id: id)
                    }
                }
            }
        }
    }
}

extension MVVM.PokemonListView {
    struct ContentView: View {

        @Binding var toast: Toast?
        private let pokemonList: [PokemonData]
        private let loadMore: (Int) -> Void

        init(
            pokemonList: [PokemonData],
            toast: Binding<Toast?>,
            loadMore: @escaping (Int) -> Void
        ) {
            self.pokemonList = pokemonList
            self._toast = toast
            self.loadMore = loadMore
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
                .overlay {
                    NavigationLink(
                        destination: Text(pokemon.name)
                    ) {}.opacity(0)
                }
                .onAppear {
                    loadMore(pokemon.id)
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

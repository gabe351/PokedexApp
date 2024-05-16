import SwiftUI

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

extension PokemonListView {
    struct ContentView: View {

        @Binding var toast: Toast?
        private let pokemonList: [PokemonData]
        private let loadMore: (Int) -> Void

        private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 150))
        ]

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
            ScrollView {
                LazyVGrid(columns: adaptiveColumn) {
                    ForEach(pokemonList, id: \.id) { pokemon in
                        NavigationLink(
                            destination: {
                                PokemonDetailView(pokemon: pokemon)
                            },
                            label: {
                                PokemonCellView(
                                    toast: $toast,
                                    pokemon: pokemon
                                )
                                .overlay {
                                    NavigationLink(
                                        destination: Text(pokemon.name)
                                    ) {}.opacity(0)
                                }
                            }
                        )
                        .onAppear {
                            loadMore(pokemon.id)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }

        }
    }
}

#Preview {
    PokemonListView(viewModel: .init(), toast: .constant(.init(
        style: .success,
        message: "Saved"
    )))
}

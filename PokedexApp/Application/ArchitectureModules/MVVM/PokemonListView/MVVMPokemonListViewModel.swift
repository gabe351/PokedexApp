import SwiftUI

extension MVVM {

    protocol PokemonListViewModelProtocol: LodableObject {
        /// Fetch pokemon list from pokeapi
        func fetchList()

        /// Fetch pokemon data next page
        /// - Parameters:
        ///     - id: identifier to check if this is the last element
        func fetchNextPageIfNeeded(id: Int)
    }

    final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {
        typealias Output = PokedexDto
        @Published var state: LoadingState<PokedexDto>
        var pokedexData: PokedexDto?

        private let remoteService: RemoteDataSourceProtocol

        init(
            state: LoadingState<PokedexDto> = .loading,
            remoteService: RemoteDataSourceProtocol = RemoteDataSource()
        ) {
            self.state = state
            self.remoteService = remoteService

            fetchList()
        }

        func fetchList() {
            DispatchQueue.main.async { [weak self] in
                self?.fetch { result in
                    self?.pokedexData = result
                    self?.state = .loaded(result)
                }
            }
        }

        @MainActor 
        func fetchNextPageIfNeeded(id: Int) {
            guard var pokedexData, 
                    let next = pokedexData.next else {
                return
            }

            if shouldFecthNextPage(id: id) {
                fetch(api: .customURL(value: next)) { [weak self] result in
                    pokedexData.next = result.next
                    pokedexData.pokemonList.append(contentsOf: result.pokemonList)
                    self?.pokedexData = pokedexData
                    self?.state = .loaded(pokedexData)
                }
            }
        }

        @MainActor
        private func fetch(api: Api = .firstPage, completion: @escaping (PokedexDto) -> Void) {
            Task {
                do {
                    var result = try await remoteService.fetchPokemonList(api: api)
                    result.pokemonList.sort { $0.id < $1.id }
                    completion(result)
                } catch {
                    let networkError = error as? ApiProvider.NetworkError
                    guard let networkError else {
                        state = .error(message: Strings.defaultError.text)
                        return
                    }

                    state = .error(message: Strings.getErrorMessage(networkError))
                }
            }
        }

        private func shouldFecthNextPage(id: Int) -> Bool {
            let last = pokedexData?.pokemonList.last
            return last?.id == id
        }
    }
}

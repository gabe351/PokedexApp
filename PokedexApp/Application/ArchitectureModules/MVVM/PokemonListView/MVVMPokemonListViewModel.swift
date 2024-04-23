import SwiftUI

extension MVVM {

    protocol PokemonListViewModelProtocol: LodableObject {
        func fetchList()
    }

    final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {
        typealias Output = [PokemonData]
        @Published var state: LoadingState<[PokemonData]>

        private let remoteService: RemoteDataSourceProtocol

        init(
            state: LoadingState<[PokemonData]> = .loading,
            remoteService: RemoteDataSourceProtocol = RemoteDataSource()
        ) {
            self.state = state
            self.remoteService = remoteService
        }

        @MainActor
        func fetchList() {
            Task {
                do {
                    var result = try await remoteService.fetchPokemonList()
                    result.sort { $0.id < $1.id }
                    state = .loaded(result)
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
    }
}

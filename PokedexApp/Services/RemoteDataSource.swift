import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
    /// Fetch pokemon list from pokeapi
    func fetchPokemonList() async throws -> [PokemonData]
}

final class RemoteDataSource: RemoteDataSourceProtocol {
    func fetchPokemonList() async throws -> [PokemonData] {
        var result = [PokemonData]()
        let baseResponse: PokemonListBaseResponse = try await ApiProvider
            .shared.request(.baseUrl)
        let baseList = baseResponse.results

        guard let baseList else {
            return result
        }

        try await withThrowingTaskGroup(of: PokemonData.self) { group in
            baseList.forEach { pokemonResponse in
                group.addTask {
                    let url = pokemonResponse.url
                    return try await ApiProvider.shared
                        .request(.customURL(value: url))
                }
            }

            for try await pokemonData in group {
                result.append(pokemonData)
            }
        }

        return result
    }
}

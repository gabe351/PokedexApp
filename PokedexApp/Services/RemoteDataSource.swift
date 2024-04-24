import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
    /// Fetch pokemon list from pokeapi
    /// - Parameters:
    ///     - Api: Api enum value to handle request
    func fetchPokemonList(api: Api) async throws -> PokedexDto
}

final class RemoteDataSource: RemoteDataSourceProtocol {
    func fetchPokemonList(api: Api) async throws -> PokedexDto {
        var pokemonList = [PokemonData]()
        let baseResponse: PokemonListBaseResponse = try await ApiProvider
            .shared.request(api)
        let baseList = baseResponse.results

        try await withThrowingTaskGroup(of: PokemonData.self) { group in
            baseList?.forEach { pokemonResponse in
                group.addTask {
                    let url = pokemonResponse.url
                    return try await ApiProvider.shared
                        .request(.customURL(value: url))
                }
            }

            for try await pokemonData in group {
                pokemonList.append(pokemonData)
            }
        }

        return PokedexDto(
            data: baseResponse,
            pokemonList: pokemonList
        )
    }
}

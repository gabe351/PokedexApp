import Foundation

//TODO: Need to refactor for a better implementation
struct PokemonListApiService {
    func fetchPokemonList() async throws -> [PokemonData] {
        var result = [PokemonData]()
        let baseResponse = try await fetchBasePokemonList()
        let baseList = baseResponse.results

        guard let baseList else {
            return result
        }

        try await withThrowingTaskGroup(of: PokemonData.self) { group in
            baseList.forEach { pokemonResponse in
                if let url = URL(string: pokemonResponse.url) {
                    group.addTask {
                        print("Added task to group")
                        return try await fetchPokemonData(url: url)
                    }
                }
            }

            for try await pokemonData in group {
                print("Added pokemon to result")
                result.append(pokemonData)
            }
        }

        return result
    }

    func fetchBasePokemonList() async throws -> PokemonListBaseResponse {
        guard let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            throw NSError(
                domain: "com.gabe.app",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Invalid URL"
                ]
            )
        }

        let (data, _) = try await URLSession.shared.data(from: baseUrl)
        print("Fetch geral")
        return try JSONDecoder().decode(PokemonListBaseResponse.self, from: data)
    }

    func fetchPokemonData(url: URL) async throws -> PokemonData {
        let (data, _) = try await URLSession.shared.data(from: url)
        print("Finished fetch Pokemon \(url)")
        return try JSONDecoder().decode(PokemonData.self, from: data)
    }
}

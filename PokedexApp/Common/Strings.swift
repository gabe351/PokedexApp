import Foundation

enum Strings {
    static let subtitle = "Pokedex app to list and capture pokemons"
    static let description = "In this project you will be able to see the same app implemented in different architectural patterns:"
    static let author = "Gabriel Rosa"
    static let savedSuccess = "Pokemon saved!"

    static func checkoutText(_ branchName: String) -> String {
        return "git fetch && git checkout \(branchName)"
    }
}

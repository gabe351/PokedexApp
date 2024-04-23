import Foundation

enum Strings {
    case loading
    case subtitle
    case description
    case author
    case savedSuccess
    case alreadySaved
    case defaultError
    case invalidUrl
    case httpError(code: Int)


    var text: String {
        switch self {
        case .loading:
            return "Loading"
        case .subtitle:
            return "Pokedex app to list and capture pokemons"
        case .description:
            return "In this project you will be able to see the same app implemented in different architectural patterns:"
        case .author:
            return "Gabriel Rosa"
        case .alreadySaved:
            return "You already saved this pokemon"
        case .savedSuccess:
            return "Pokemon saved!"
        case .defaultError:
            return "Something went wrong"
        case .invalidUrl:
            return "Error fetching with invalid URL"
        case .httpError(let code):
            return "HTTP Error status code: \(code)"
        }
    }

    static func getErrorMessage(_ error: ApiProvider.NetworkError) -> String {
        switch error {
        case .httpError(let code):
            return self.httpError(code: code).text
        case .invalidUrl:
            return self.invalidUrl.text
        case .badResponse:
            return self.defaultError.text
        }
    }
}

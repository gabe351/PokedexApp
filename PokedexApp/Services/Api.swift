import Foundation

enum Api {

    case firstPage
    case customURL(value: String)

    var path: URL? {

        switch self {

        case .firstPage:
            return URL(string: "https://pokeapi.co/api/v2/pokemon")
        case .customURL(let value):
            return URL(string: value)
        }
    }
}

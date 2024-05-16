import SwiftUI

enum PokemonTypeColors: String {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy

    static func getColor(_ typeText: String) -> Color {
        guard let type = PokemonTypeColors(rawValue: typeText) else {
            return Color(hex: self.normal.colorHex)
        }

        return Color(hex: type.colorHex)
    }

    private var colorHex: String {
        switch self {
        case .normal:
            return "#A8A77A"
        case .fire:
            return "#EE8130"
        case .water:
            return "#6390F0"
        case .electric:
            return "#F7D02C"
        case .grass:
            return "#7AC74C"
        case .ice:
            return "#96D9D6"
        case .fighting:
            return "#C22E28"
        case .poison:
            return "#A33EA1"
        case .ground:
            return "#E2BF65"
        case .flying:
            return "#A98FF3"
        case .psychic:
            return "#F95587"
        case .bug:
            return "#A6B91A"
        case .rock:
            return "#B6A136"
        case .ghost:
            return "#735797"
        case .dragon:
            return "#6F35FC"
        case .dark:
            return "#705746"
        case .steel:
            return "#B7B7CE"
        case .fairy:
            return "#D685AD"
        }
    }
}

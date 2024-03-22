import Foundation

struct BaseMoveResponse: Decodable {
    let move: MoveResponse
}

struct MoveResponse: Decodable {
    let name: String
}

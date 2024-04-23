import Foundation

enum LoadingState<Output> {
    case loading
    case loaded(_ result: Output)
    case error(message: String)
}

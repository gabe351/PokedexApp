import SwiftUI

protocol LodableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
}

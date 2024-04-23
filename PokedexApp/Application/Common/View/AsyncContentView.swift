import SwiftUI

struct AsyncContentView<Source: LodableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content

    init(
        source: Source,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .loading:
            LoadingView()
        case .error(let message):
            ErrorView(message: message)
        case .loaded(let output):
            content(output)
        }
    }
}

import SwiftUI
import UniformTypeIdentifiers

struct DetailView: View {

    private let module: ArchitectureType

    init(module: ArchitectureType) {
        self.module = module
    }

    var body: some View {
        VStack {

            switch module {
            case .mvvm:
                MVVM.HomeView()
            case .mvp:
                MVP.HomeView()
            case .tca:
                TCA.HomeView()
            }
        }
    }
}

#Preview {
    DetailView(
        module: .mvvm
    )
}

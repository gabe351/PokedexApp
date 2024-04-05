import SwiftUI

extension MVVM {
    struct PokemonListView: View {
        @State private var toast: Toast? = nil
        
        var body: some View {
            VStack {
                Spacer()
                Text("Display list of pokemons from server")
                    .onTapGesture {
                        toast = Toast(
                            style: .success,
                            message: Strings.savedSuccess
                        )
                    }
                Spacer()
            }
            .toastView(toast: $toast)
        }
    }

    #Preview {
        PokemonListView()
    }
}


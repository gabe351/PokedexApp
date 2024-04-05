import SwiftUI

extension MVP {
    struct PokemonListView: View {
        var body: some View {
            VStack {
                Spacer()
                Text("Display list of pokemons from server with MVP")
                Spacer()
            }
        }
    }

    #Preview {
        PokemonListView()
    }
}


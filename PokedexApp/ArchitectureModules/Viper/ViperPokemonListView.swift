import SwiftUI

extension Viper {
    struct PokemonListView: View {
        var body: some View {
            VStack {
                Spacer()
                Text("Display list of pokemons from server with TCA")
                Spacer()
            }
        }
    }

    #Preview {
        PokemonListView()
    }
}


import SwiftUI

struct TCA {
    struct HomeView: View {

        @State private var selectedTab: Tabs = .list

        var body: some View {
            TabView(selection: $selectedTab) {
                PokemonListView()
                    .tabItem {
                        selectedTab == .list
                        ? Image(.pokedexRed)
                        : Image(.pokedexBlack)
                    }
                    .tag(Tabs.list)

                SavedPokemonView()
                    .tabItem {
                        selectedTab == .saved
                        ? Image(.pokeballRed)
                        : Image(.pokeballGray)

                    }
                    .tag(Tabs.saved)
            }
            .navigationTitle(selectedTab.rawValue)
            .navigationBarTitleDisplayMode(.automatic)
        }

        private enum Tabs: String {
            case list = "Pokemon List"
            case saved = "Saved pokemons"
        }
    }

    #Preview {
        HomeView()
    }
}

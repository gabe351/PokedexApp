import SwiftUI

struct HomeView: View {

    @State private var toast: Toast? = nil
    @State private var selectedTab: Tabs = .list
    @StateObject var listViewModel = PokemonListViewModel()
    let savedListView = SavedPokemonView()

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                PokemonListView(
                    viewModel: listViewModel,
                    toast: $toast
                )
                .tabItem {
                    selectedTab == .list
                    ? Image(.pokedexRed)
                    : Image(.pokedexBlack)
                }
                .tag(Tabs.list)

                savedListView
                    .tabItem {
                        selectedTab == .saved
                        ? Image(.pokeballRed)
                        : Image(.pokeballGray)

                    }
                    .tag(Tabs.saved)
            }
            .toastView(toast: $toast)
            .navigationTitle(selectedTab.rawValue)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .tint(.red)
                    }
                }
            }
        }
    }

    private enum Tabs: String {
        case list = "Pokemon List"
        case saved = "Saved pokemons"
    }
}

#Preview {
    HomeView()
}

import SwiftUI
import UniformTypeIdentifiers

struct MainView: View {

    @State private var isShowingDetailView = false
    @State private var toast: Toast? = nil

    var body: some View {
        NavigationStack {
            Image(.pokemonLogo)
                .padding(.bottom)

            Text(Strings.subtitle)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(Strings.description)
                .padding()
                .multilineTextAlignment(.center)
                .font(.callout)
            List(getArchItems()) { item in
                ListItemView(item: item)
                    .listRowBackground(Color.clear)
                    .overlay {
                        NavigationLink(
                            destination: DetailView(
                                module: item.type
                            )
                        ) {}.opacity(0)
                    }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            Spacer()

            FooterView()
        }
        .accentColor(.red)
        .toastView(toast: $toast)
    }
}

private extension MainView {

    struct ListItemView: View {

        private let item: ArchitectureItem

        init(
            item: ArchitectureItem
        ) {
            self.item = item
        }

        var body: some View {
            HStack {
                Text(item.title)
                    .bold()
                    .foregroundStyle(.black)
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .renderingMode(.template)
                    .foregroundStyle(.black)
                    .padding(.horizontal)
            }.background {
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius
                )
                .background(.clear)
                .foregroundColor(.yellow)
            }
        }
    }

    struct FooterView: View {

        @State private var isPresentGitWebView = false
        @State private var isPresentLinkedInView = false

        var body: some View {
            HStack {
                Button(action: {
                    isPresentLinkedInView = true
                }, label: {
                    Image(.linkedIn)
                })
                .fullScreenCover(isPresented: $isPresentLinkedInView) {
                    if let url = URL(string: Links.linkedInLink) {
                        SafariWebView(url: url)
                            .ignoresSafeArea()
                    }
                }

                Button(action: {
                    isPresentGitWebView = true
                }, label: {
                    Image(.github)
                })
                .fullScreenCover(isPresented: $isPresentGitWebView) {
                    if let url = URL(string: Links.githubLink) {
                        SafariWebView(url: url)
                            .ignoresSafeArea()
                    }
                }

                Text(Strings.author)
            }
        }
    }
}

private extension MainView {

    func getArchItems() -> [ArchitectureItem] {
        [
            ArchitectureItem(
                type: .mvvm
            ),
            ArchitectureItem(
                type: .mvp
            ),
            ArchitectureItem(
                type: .viper
            ),
            ArchitectureItem(
                type: .tca
            )
        ]
    }

    enum Constants {
        static let cornerRadius: CGFloat = 12.0
    }
}

#Preview {
    MainView()
}

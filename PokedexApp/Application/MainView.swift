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
            List {
                ForEach(getArchItems()) { item in
                    ListItemView(item: item) {
                        if item.isCurrentBranch {
                            isShowingDetailView = true
                        } else {
                            excuteCopy(item.branchName)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .navigationDestination(
                 isPresented: $isShowingDetailView
            ) {
                DetailView()
            }
            .listStyle(.plain)

            Spacer()

            FooterView()
        }
        .toastView(toast: $toast)
        .padding()
    }
}

private extension MainView {

    struct ListItemView: View {

        private let item: ArchitectureItem
        private let navigationAction: () -> Void

        init(
            item: ArchitectureItem,
            navigationAction: @escaping () -> Void
        ) {
            self.item = item
            self.navigationAction = navigationAction
        }

        var body: some View {
            HStack {
                Text(item.title)
                    .bold()
                    .foregroundStyle(.black)
                    .padding()
                Spacer()
                Image(systemName: item.iconName)
                    .renderingMode(.template)
                    .foregroundStyle(.black)
                    .padding(.horizontal)
            }.background {
                if item.isCurrentBranch {
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius
                    )
                    .background(.clear)
                    .foregroundColor(.yellow)
                } else {
                    RoundedRectangle(
                        cornerRadius: Constants.cornerRadius
                    )
                    .stroke(
                        .yellow,
                        lineWidth: Constants.borderWidth
                    )
                }
            }
            .onTapGesture {
                navigationAction()
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
                title: "MVVM",
                branchName: "mvvm",
                isCurrentBranch: false
            ),
            ArchitectureItem(
                title: "MVP",
                branchName: "mvp",
                isCurrentBranch: false
            ),
            ArchitectureItem(
                title: "VIPER",
                branchName: "viper",
                isCurrentBranch: false
            ),
            ArchitectureItem(
                title: "TCA",
                branchName: "tca",
                isCurrentBranch: false
            )
        ]
    }

    func excuteCopy(_ branchName: String) {
        toast = Toast(
            style: .info,
            message: Strings.toastTitle
        )

        let command = Strings
            .checkoutText(branchName)

        UIPasteboard
            .general
            .string = command
    }

    enum Strings {
        static let subtitle = "Pokedex app to list and capture pokemons"
        static let description = "In this project you will be able to see the same app implemented in different architectural patterns in multiple branches:"
        static let author = "Gabriel Rosa"
        static let toastTitle = "git command on clipboard."

        static func checkoutText(_ branchName: String) -> String {
            return "git fetch && git checkout \(branchName)"
        }
    }

    enum Constants {
        static let cornerRadius: CGFloat = 12.0
        static let borderWidth: CGFloat = 2.0
    }
}

#Preview {
    MainView()
}

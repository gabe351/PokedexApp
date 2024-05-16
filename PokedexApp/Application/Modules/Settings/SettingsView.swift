import SwiftUI
import UniformTypeIdentifiers

struct SettingsView: View {

    @State private var isShowingDetailView = false
    @State private var toast: Toast? = nil

    var body: some View {
        NavigationStack {
            Image(.pokemonLogo)
                .padding(.bottom)

            Text(Strings.subtitle.text)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(Strings.description.text)
                .padding()
                .multilineTextAlignment(.center)
                .font(.callout)

            Text("Add settings options like theme or username")
                .padding()
                .multilineTextAlignment(.center)
                .fontWeight(.bold)

            Spacer()

            FooterView()
        }
        .accentColor(.red)
        .toastView(toast: $toast)
    }
}

private extension SettingsView {
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

                Text(Strings.author.text)
            }
        }
    }
}

private extension SettingsView {

    enum Constants {
        static let cornerRadius: CGFloat = 12.0
    }
}

#Preview {
    SettingsView()
}

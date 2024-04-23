//
//  LoadingView.swift
//  PokedexApp
//
//  Created by Gabriel Rosa on 4/19/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView {
                Text(Strings.loading.text)
            }
        }
    }
}

#Preview {
    LoadingView()
}

//
//  ErrorView.swift
//  PokedexApp
//
//  Created by Gabriel Rosa on 4/22/24.
//

import SwiftUI

struct ErrorView: View {

    private let message: String

    init(message: String) {
        self.message = message
    }

    var body: some View {
        Text(message)
    }
}

#Preview {
    ErrorView(
        message: "Failed to load data"
    )
}

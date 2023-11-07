//
//  BackgroundView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image(.flappyBirdBackground)
            .resizable()
            .ignoresSafeArea()
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -50, trailing: -20))
    }
}

#Preview {
    BackgroundView()
}

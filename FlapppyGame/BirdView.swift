//
//  BirdView.swift
//  FlapppyGame
//
//  Created by Yury on 06.11.23.
//

import SwiftUI

struct BirdView: View {
    let birdSize: CGFloat
    
    var body: some View {
        Image(.flappyBird)
            .resizable()
            .scaledToFit()
            .frame(width: birdSize, height: birdSize)
    }
}

#Preview {
    BirdView(birdSize: 80)
}

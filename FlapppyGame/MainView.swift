//
//  MainView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct MainView: View {
    private let birdPosition = CGPoint(x: 100, y: 300)
    private let topHeightTube: CGFloat = .random(in: 100...500)
    private let pipeWidth: CGFloat = 100
    private let tubeSpacing: CGFloat = 100
    private let tubesOffset: CGFloat = 0
    private let scores = 0
    
    var body: some View {
        GeometryReader { geomytry in
            NavigationStack {
                ZStack {
                    Image(.flappyBirdBackground)
                        .resizable()
                        .ignoresSafeArea()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -50, trailing: -20))
                    
                    BirdView()
                        .position(birdPosition)
                    
                    TubesView(
                        tubeHeight: topHeightTube,
                        tubeWidth: pipeWidth,
                        tubesSpacing: tubeSpacing
                    )
                    .offset(x: geomytry.size.width + tubesOffset)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Text(scores.formatted())
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}

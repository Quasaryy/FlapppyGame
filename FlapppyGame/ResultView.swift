//
//  ResultView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let highScore: Int
    let resetAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .padding()
            Text("Score: \(score)")
                .font(.title)
            Text("BEST: \(highScore)")
                .padding()
            Button("RESET", action: resetAction)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding()
        }
        .background(.white.opacity(0.8))
        .clipShape(.rect(cornerRadius: 20))
        .padding()
    }
}

#Preview {
    ResultView(score: 0, highScore: 0, resetAction: {})
}

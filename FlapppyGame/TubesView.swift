//
//  TubesView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct TubesView: View {
    let topTubeHeight: CGFloat
    let tubeWidth: CGFloat
    let tubeSpacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height - tubeSpacing
            let bottomPipeHeight = availableHeight - topTubeHeight
            
            VStack {
                // Верхняя труба
                Image(.flappeBirdPipe)
                    .resizable()
                    .rotationEffect(.degrees(180))
                    .frame(width: tubeWidth, height: topTubeHeight)
                
                Spacer()
                    .frame(height: tubeSpacing)
                
                Image(.flappeBirdPipe)
                    .resizable()
                    .frame(width: tubeWidth, height: bottomPipeHeight)
            }
        }
    }
}

#Preview {
    TubesView(topTubeHeight: 300, tubeWidth: 100, tubeSpacing: 100)
}


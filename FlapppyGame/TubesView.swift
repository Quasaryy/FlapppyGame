//
//  TubesView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct TubesView: View {
    let tubeHeight: CGFloat
    let tubeWidth: CGFloat
    let tubesSpacing: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let availableSpace = geometry.size.height - tubesSpacing
            let bottomTubeHeight = availableSpace - tubeHeight
            VStack {
                // Верхняя труба
                Image(.flappeBirdPipe)
                    .resizable()
                    .rotationEffect(.degrees(180))
                    .frame(width: tubeWidth, height: tubeHeight)
                
                Spacer()
                    .frame(height: tubesSpacing)
                
                // Нижняя труба
                Image(.flappeBirdPipe)
                    .resizable()
                    .frame(width: tubeWidth, height: bottomTubeHeight)
            }
        }
    }
}

#Preview {
    TubesView(tubeHeight: 300, tubeWidth: 100, tubesSpacing: 100)
}

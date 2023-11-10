//
//  MainView.swift
//  FlapppyGame
//
//  Created by Yury on 07.11.23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GameViewModel()
    
    private let birdSize: CGFloat = 80
    private let pipeWidth: CGFloat = 100
    private let pipeSpacing: CGFloat = 100
    private let groundHeight: CGFloat = 100
    
    private let timer = Timer.publish(
        every: 0.01,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Image(.flappyBirdBackground)
                        .resizable()
                        .ignoresSafeArea()
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: -50,
                                trailing: -30
                            )
                        )
                    
                    BirdView(birdSize: birdSize)
                        .position(viewModel.birdPosition)
                    
                    TubesView(
                        topTubeHeight: viewModel.topPipeHeight,
                        tubeWidth: pipeWidth,
                        tubeSpacing: pipeSpacing
                    )
                    .offset(x: geometry.size.width + viewModel.pipeOffset)
                    
                    if viewModel.gameState == .ready {
                        Button(action: viewModel.startGame) {
                            Image(systemName: "play.fill")
                        }
                        .font(Font.system(size: 60))
                        .foregroundStyle(.white)
                    }
                    
                    if viewModel.gameState == .stopped {
                        ResultView(score: viewModel.scores, highScore: viewModel.highScore) {
                            viewModel.resetGame()
                        }
                    }
                }
                .onTapGesture {
                    viewModel.birdJump()
                }
                .onReceive(timer) { currentTime in
                    guard viewModel.gameState == .active else { return }
                    let deltaTime = currentTime.timeIntervalSince(viewModel.lastUpdateTime)
                    
                    viewModel.applyGravity(deltaTime: deltaTime)
                    viewModel.updateBirdPosition(deltaTime: deltaTime)
                    viewModel.checkBoundaries(geometry: geometry)
                    viewModel.updatePipePosition(deltaTime: deltaTime)
                    viewModel.resetPipePositionIfNeeded(geometry: geometry)
                    
                    if viewModel.checkCollisions(geometry: geometry) {
                        viewModel.gameState = .stopped
                    }
                    
                    viewModel.updateScores(geometry: geometry)
                    viewModel.lastUpdateTime = currentTime
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Text(viewModel.scores.formatted())
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

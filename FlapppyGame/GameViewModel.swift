//
//  GameViewModel.swift
//  FlapppyGame
//
//  Created by Yury on 10.11.23.
//

import SwiftUI

enum GameState {
    case ready, active, stopped
}

class GameViewModel: ObservableObject {
    @AppStorage(wrappedValue: 0, "highScore") var highScore: Int
    @Published var birdPosition = CGPoint(x: 100, y: 300)
    @Published var birdVelocity = CGVector(dx: 0, dy: 0)
    @Published var pipeOffset: CGFloat = 0
    @Published var topPipeHeight = CGFloat.random(in: 100...500)
    @Published var gameState: GameState = .ready
    @Published var scores = 0
    
    private let birdRadius: CGFloat = 13
    let pipeWidth: CGFloat = 100
    private let pipeSpacing: CGFloat = 100
    private let jumpVelocity = -400
    private let gravity: CGFloat = 1000
    private let groundHeight: CGFloat = 100
    var lastUpdateTime = Date()
    private var passedPipe = false
    
    func applyGravity(deltaTime: TimeInterval) {
        birdVelocity.dy += CGFloat(gravity * deltaTime)
    }
    
    func updateBirdPosition(deltaTime: TimeInterval) {
        birdPosition.y += birdVelocity.dy * CGFloat(deltaTime)
    }
    
    func checkBoundaries(geometry: GeometryProxy) {
        if birdPosition.y <= 0 {
            birdPosition.y = 0
            gameState = .stopped
        }
        
        if birdPosition.y > geometry.size.height - groundHeight {
            birdPosition.y = geometry.size.height - groundHeight
            birdVelocity.dy = 0
            gameState = .stopped
        }
    }
    
    func checkCollisions(geometry: GeometryProxy) -> Bool {
        let birdFrame = CGRect(
            x: birdPosition.x - birdRadius / 2,
            y: birdPosition.y - birdRadius / 2,
            width: birdRadius,
            height: birdRadius
        )
        
        let topPipeFrame = CGRect(
            x: geometry.size.width + pipeOffset,
            y: 0,
            width: pipeWidth,
            height: topPipeHeight
        )
        
        let bottomPipeFrame = CGRect(
            x: geometry.size.width + pipeOffset,
            y: topPipeHeight + pipeSpacing,
            width: pipeWidth,
            height: geometry.size.height - topPipeHeight - pipeSpacing
        )
        
        return birdFrame.intersects(topPipeFrame) || birdFrame.intersects(bottomPipeFrame)
    }
    
    func updatePipePosition(deltaTime: TimeInterval) {
        pipeOffset -= CGFloat(300 * deltaTime)
    }
    
    func resetPipePositionIfNeeded(geometry: GeometryProxy) {
        if pipeOffset <= -geometry.size.width - pipeWidth {
            pipeOffset = 0
            topPipeHeight = CGFloat.random(in: 100...500)
        }
    }
    
    func updateScores(geometry: GeometryProxy) {
        if pipeOffset + pipeWidth + geometry.size.width < birdPosition.x && !passedPipe {
            scores += 1
            if scores > highScore {
                highScore = scores
            }
            passedPipe = true
        } else if pipeOffset + geometry.size.width > birdPosition.x {
            passedPipe = false
        }
    }
    
    func resetGame() {
        birdPosition = CGPoint(x: 100, y: 300)
        birdVelocity = CGVector(dx: 0, dy: 0)
        pipeOffset = 0
        topPipeHeight = CGFloat.random(in: 100...500)
        scores = 0
        gameState = .ready
    }
    
    func startGame() {
        gameState = .active
        lastUpdateTime = Date()
    }
    
    func birdJump() {
        birdVelocity = CGVector(dx: 0, dy: jumpVelocity)
    }
}

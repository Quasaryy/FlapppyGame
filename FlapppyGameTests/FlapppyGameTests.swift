//
//  FlapppyGameTests.swift
//  FlapppyGameTests
//
//  Created by Yury on 10.11.23.
//

import XCTest
@testable import FlapppyGame

final class FlapppyGameTests: XCTestCase {
    
    var viewModel: GameViewModel!

    override func setUpWithError() throws {
        viewModel = GameViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testApplyGravity() {
        let initialVelocityY = viewModel.birdVelocity.dy
        viewModel.applyGravity(deltaTime: 1.0)
        XCTAssertTrue(viewModel.birdVelocity.dy > initialVelocityY, "Gravity should increase the downward velocity")
    }
    
    func testUpdateBirdPosition() {
        let initialPositionY = viewModel.birdPosition.y
        viewModel.birdVelocity.dy = 100
        viewModel.updateBirdPosition(deltaTime: 1.0)
        XCTAssertTrue(viewModel.birdPosition.y > initialPositionY, "Bird's position should increase with positive velocity")
    }
    
    func testUpdatePipePosition() {
        let initialPipeOffset = viewModel.pipeOffset
        viewModel.updatePipePosition(deltaTime: 1.0)
        XCTAssertTrue(viewModel.pipeOffset < initialPipeOffset, "Pipe offset should decrease over time")
    }
    
    // Тест проверяет, правильно ли сбрасываются все свойства при вызове resetGame
    func testResetGame() {
        viewModel.scores = 10
        viewModel.birdPosition = CGPoint(x: 50, y: 50)
        viewModel.birdVelocity = CGVector(dx: 5, dy: 5)

        viewModel.resetGame()

        XCTAssertEqual(viewModel.scores, 0, "Scores should be reset to 0")
        XCTAssertEqual(viewModel.birdPosition, CGPoint(x: 100, y: 300), "Bird position should be reset")
        XCTAssertEqual(viewModel.birdVelocity, CGVector(dx: 0, dy: 0), "Bird velocity should be reset")
        XCTAssertEqual(viewModel.gameState, .ready, "Game state should be set to ready")
    }
    
    // Тест проверяет, устанавливается ли состояние игры в .active при вызове startGame
    func testStartGame() {
        viewModel.startGame()
        XCTAssertEqual(viewModel.gameState, .active)
    }
    
    // Тест проверяет изменение вертикальной скорости после прыжка.
    func testBirdJump() {
        let initialVelocityY = viewModel.birdVelocity.dy
        viewModel.birdJump()
        XCTAssertNotEqual(viewModel.birdVelocity.dy, initialVelocityY)
    }
    
}

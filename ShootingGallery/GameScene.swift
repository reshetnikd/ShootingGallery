//
//  GameScene.swift
//  ShootingGallery
//
//  Created by Dmitry Reshetnik on 29.04.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var timerLabel: SKLabelNode!
    var secondsRemaining = 60 {
        didSet {
            timerLabel.text = "\(secondsRemaining)"
        }
    }
    var clipLabel: SKLabelNode!
    var bulletsRemaining = 6 {
        didSet {
            clipLabel.text = "\(String(repeating: "I", count: bulletsRemaining))"
        }
    }
    
    let targets = ["target1", "target2", "target3"]
    var isGameOver = false
    var gameTimer: Timer?
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: 512, y: 384)
        background.size = self.size
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        let curtains = SKSpriteNode(imageNamed: "curtains")
        curtains.position = CGPoint(x: 512, y: 384)
        curtains.size = self.size
        addChild(curtains)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: 8, y: 8)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontSize = 48
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel.text = "60"
        timerLabel.position = CGPoint(x: 992, y: 8)
        timerLabel.horizontalAlignmentMode = .right
        timerLabel.fontSize = 48
        timerLabel.zPosition = 1
        addChild(timerLabel)
        
        clipLabel = SKLabelNode(fontNamed: "Chalkduster")
        clipLabel.text = "\(String(repeating: "I", count: bulletsRemaining))"
        clipLabel.position = CGPoint(x: 8, y: 708)
        clipLabel.horizontalAlignmentMode = .left
        clipLabel.fontSize = 48
        clipLabel.zPosition = 1
        addChild(clipLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTargets), userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            
            run(SKAction.playSoundFileNamed("shot", waitForCompletion: false))
            bulletsRemaining -= 1
            
            if bulletsRemaining == 0 {
                run(SKAction.playSoundFileNamed("reload", waitForCompletion: true))
                bulletsRemaining = 6
            }
            
            if node.name == "target0" {
                node.removeFromParent()
                score += 1
            } else if node.name == "target1" {
                node.removeFromParent()
                score += 2
            } else if node.name == "target2" {
                node.removeFromParent()
                score += 3
            }
        }
    }
    
    @objc func createTargets() {
        // TODO: Create a row of targets.
        let target0 = SKSpriteNode(imageNamed: targets[0])
        target0.position = CGPoint(x: 1200, y: 484)
        target0.name = "target0"
        target0.zPosition = -1
        addChild(target0)
        
        target0.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 1000, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: 800, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: 600, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: 400, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: 200, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: 0, y: 484), duration: 0.5), SKAction.move(to: CGPoint(x: -200, y: 484), duration: 0.5)]))
        
        let target1 = SKSpriteNode(imageNamed: targets[1])
        target1.position = CGPoint(x: 0, y: 384)
        target1.name = "target1"
        target1.zPosition = -1
        addChild(target1)
        
        target1.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 200, y: 384), duration: 0.4), SKAction.move(to: CGPoint(x: 400, y: 384), duration: 0.4), SKAction.move(to: CGPoint(x: 600, y: 384), duration: 0.4), SKAction.move(to: CGPoint(x: 800, y: 384), duration: 0.4), SKAction.move(to: CGPoint(x: 1000, y: 384), duration: 0.4), SKAction.move(to: CGPoint(x: 1200, y: 384), duration: 0.4)]))
        
        let target2 = SKSpriteNode(imageNamed: targets[2])
        target2.position = CGPoint(x: 1200, y: 284)
        target2.name = "target2"
        target2.zPosition = -1
        addChild(target2)
        
        target2.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 1000, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: 800, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: 600, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: 400, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: 200, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: 0, y: 284), duration: 0.2), SKAction.move(to: CGPoint(x: -200, y: 284), duration: 0.2)]))
        
        if secondsRemaining == 0 {
            gameTimer?.invalidate()
            
            run(SKAction.playSoundFileNamed("empty", waitForCompletion: false))
            
            let gameOver = SKSpriteNode(imageNamed: "game-over")
            gameOver.position = CGPoint(x: 512, y: 384)
            gameOver.zPosition = 1
            addChild(gameOver)
        } else {
            secondsRemaining -= 1
        }
    }
}

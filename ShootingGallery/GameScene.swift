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
            clipLabel.text = "Bullets: \(bulletsRemaining)"
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTargets), userInfo: nil, repeats: true)
        
    }
    
    @objc func createTargets() {
        // TODO: Create a row of targets.
    }
}

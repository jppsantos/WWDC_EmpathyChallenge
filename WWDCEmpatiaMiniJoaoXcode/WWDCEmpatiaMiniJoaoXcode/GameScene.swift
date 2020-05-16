//
//  GameScene.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    lazy var gameState = GKStateMachine(states: self.sceneStates)
    
    lazy var sceneStates = [
        StartState(self),
        InitialState(self),
        SoundChallengeState(self),
        SpeechChallengeState(self),
        EmpathyChallengeState(self),
        FinalState(self)
    ]
    
    lazy var controlNode: SKNode = {
        let node = SKNode()
        node.position = CGPoint.zero
        node.name = "controlNode"
        node.zPosition = 0
        return node
    }()
    
    override func didMove(to view: SKView) {
        addChild(controlNode)
        gameState.enter(StartState.self)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


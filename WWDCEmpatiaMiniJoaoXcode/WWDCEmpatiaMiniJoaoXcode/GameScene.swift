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
        InitialState(self),
        SoundChallengeState(self),
        SpeechChallengeState(self),
        EmphatyChallengeState(self),
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
        gameState.enter(InitialState.self)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState.currentState.self is EmphatyChallengeState {
            let state = gameState.currentState as! EmphatyChallengeState
            guard let firstTouch = touches.first else { return }
            let location = firstTouch.location(in: self)
            state.touchesBegan(location: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
            let location = firstTouch.location(in: self)
            guard let node = self.nodes(at: location).first as? SKNode else {return}
            
        if node.name == "speechBubbleAudio" {
                node.position = location
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

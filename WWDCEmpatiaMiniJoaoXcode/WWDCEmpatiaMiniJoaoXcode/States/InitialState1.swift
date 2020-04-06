//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class InitialState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    
    lazy var groupNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "group")
        node.name = "groupNode"
        node.position = CGPoint(x: 0, y: 0)
        node.size = CGSize(width: 500, height: 500)
        node.zPosition = 2
        return node
    }()
    
    lazy var youNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "you")
        node.name = "groupNode"
        node.position = CGPoint(x: 50, y: 0)
        node.size = CGSize(width: 500, height: 500)
        node.zPosition = 2
        return node
    }()
    
    lazy var anaNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "ana")
        node.name = "groupNode"
        node.position = CGPoint(x: 50, y: 0)
        node.size = CGSize(width: 500 , height: 500)
        node.zPosition = 2
        return node
    }()
    
    lazy var soundButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture:   SKTexture(imageNamed: "soundButtonNormal"),
                                  selectedTexture: SKTexture(imageNamed: "soundButtonSelected"),
                                  disabledTexture: nil)
        button.setButtonAction(target: self,
                               triggerEvent: .TouchUpInside,
                               action: #selector(self.soundButtonAction))
        button.position = CGPoint(x: -420,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: 150, height: 150)
        button.name = "soundButton"
        return button
    }()
    
    lazy var speechButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "speechButtonNormal"), selectedTexture: SKTexture(imageNamed: "speechButtonSelected"), disabledTexture: SKTexture(imageNamed: "speechButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.speakButtonAction))
          button.position = CGPoint(x: -200,y: -300)
            button.zPosition = 3
            button.size = CGSize(width: 150, height: 150)
        button.name = "speechButton"
        return button
    }()
    
    lazy var empathyButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "empathyButtonNormal"), selectedTexture: SKTexture(imageNamed: "empathyButtonSelected"), disabledTexture: SKTexture(imageNamed: "empathyButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.empathyButtonAction))
        button.position = CGPoint(x: -310,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: 150, height: 150)
        button.name = "emphatyButton"
        return button
    }()
    
    
    
    init(_ gameScene: GameScene) {
           self.gameScene = gameScene
           super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is SpeechChallengeState.Type:
            return true
        case is SoundChallengeState.Type:
            return true
        case is EmpathyChallengeState.Type:
            return true
        case is FinalState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        
//        scene.addChild(groupNode)
        scene.addChild(soundButton)
        scene.addChild(speechButton)
        scene.addChild(empathyButton)
        
    }
    
    override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
    }
    
    func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    @objc func soundButtonAction() {
        self.gameScene.gameState.enter(SoundChallengeState.self)
    }
    
    @objc func speakButtonAction() {
        self.gameScene.gameState.enter(SpeechChallengeState.self)
    }
    
    @objc func empathyButtonAction() {
        self.gameScene.gameState.enter(EmpathyChallengeState.self)
    }
}




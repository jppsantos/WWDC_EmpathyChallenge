//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpeechChallengeState : GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var bubbles: [Card] = []
    
    lazy var speechButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "speechButtonNormal"), selectedTexture: SKTexture(imageNamed: "speechButtonSelected"), disabledTexture: SKTexture(imageNamed: "speechButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.speakButtonAction))
          button.position = CGPoint(x: -420,y: -300)
            button.zPosition = 3
            button.size = CGSize(width: 150, height: 150)
        button.name = "speechButton"
        return button
    }()
    
    lazy var speechBubbleNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "speechBubble")
        node.name = "speechBubble"
        node.position = CGPoint(x: 0, y: -100)
        node.size = CGSize(width: node.size.width, height: node.size.height)
        node.zPosition = 2
        return node
    }()
    
    init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is InitialState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        
        scene.addChild(speechButton)
        scene.addChild(speechBubbleNode)
        
        createBubbles()
        addAllChildren()
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
    
    func createBubbles() {
        for i in 0..<SpeechConstants.bubbles.count {
            let bubble = Card(imageNamed: SpeechConstants.bubbles[i].imageName)
            bubble.name = SpeechConstants.bubbles[i].imageName
            bubble.position = SpeechConstants.bubbles[i].position
            bubble.zPosition = 2
            bubble.size = CGSize(width: bubble.size.width * 3, height: bubble.size.height * 3)
            bubble.correctSoundName = SpeechConstants.bubbles[i].audioName
            bubble.delegate = self
            bubbles.append(bubble)
        }
    }
    
    func addAllChildren() {
        for bubble in bubbles {
            scene.addChild(bubble)
        }
    }
    
    @objc func speakButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
    

    
}

// MARK: - SpeechChallengeLogic
extension SpeechChallengeState: CardDelegate {
    
    func didTouched(element: Card) {
        let actions: [SKAction] = [
            .run { element.correctClick()},
            .wait(forDuration: 0.5),
            .run {
                let action = SKAction.move(to: SpeechConstants.newLocation, duration: 2)
                element.run(action)
            },
            .wait(forDuration: 4),
            .run { element.removeFromParent() }
        ]
        scene.run(.sequence(actions))
    }
    
    
}

//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class SpeechChallengeState : GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    
    lazy var speechButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "speechButtonNormal"), selectedTexture: SKTexture(imageNamed: "speechButtonSelected"), disabledTexture: SKTexture(imageNamed: "speechButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.speakButtonAction))
          button.position = CGPoint(x: -420,y: -300)
            button.zPosition = 3
            button.size = CGSize(width: 150, height: 150)
        button.name = "speechButton"
        return button
    }()
    
    lazy var speechBubleAudioNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "speechBubbleAudio")
        node.name = "speechBubbleAudio"
        node.position = CGPoint(x: 50, y: 0)
        node.zPosition = 2
        return node
    }()
    
    lazy var speechBubbleNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "speechBubble")
        node.name = "speechBubble"
        node.position = CGPoint(x: 0, y: -100)
        node.zPosition = 2
        return node
    }()
    
    public init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
    
    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is InitialState.Type
    }
    
    public override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        
        scene.addChild(speechButton)
        scene.addChild(speechBubbleNode)
           
        addAllChildren()
    }

    public override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
    }

    public func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    func addAllChildren() {
        guard let sba1 = self.speechBubleAudioNode.copy() as? SKSpriteNode else { return }
        guard let sba2 = self.speechBubleAudioNode.copy() as? SKSpriteNode else { return }
        guard let sba3 = self.speechBubleAudioNode.copy() as? SKSpriteNode else { return }
        guard let sba4 = self.speechBubleAudioNode.copy() as? SKSpriteNode else { return }
        
        sba1.position = CGPoint(x: -400, y: 200)
        sba2.position = CGPoint(x: -400, y: 120)
        sba3.position = CGPoint(x: -400, y: 40)
        sba4.position = CGPoint(x: -400, y: -40)
        
        scene.addChild(sba1)
        scene.addChild(sba2)
        scene.addChild(sba3)
        scene.addChild(sba4)
    }
    
    @objc public func speakButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
    

    
}

//extension SKSpriteNode {
//    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        guard let firstTouch = touches.first else { return }
//        let location = firstTouch.location(in: self)
//        guard let node = self.nodes(at: location).first as? SKNode else {return}
//        if node.name == "speechBubbleAudio" {
//            node.position = location
//        }
//
//    }
//}


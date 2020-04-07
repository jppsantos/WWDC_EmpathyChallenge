//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class FinalState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var msg: Message!
    
    lazy var youNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "youHappy")
        node.name = "groupNode"
        node.position = CGPoint(x: -150, y: 0)
        node.size = CGSize(width: node.size.width * 3, height: node.size.height * 3)
        node.zPosition = 2
        return node
    }()
    
    lazy var anaNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "anaHappy")
        node.name = "groupNode"
        node.position = CGPoint(x: 150, y: 0)
        node.size = CGSize(width: node.size.width * 3, height: node.size.height * 3)
        node.zPosition = 2
        return node
    }()
    
    lazy var nextButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "nextButton"), selectedTexture: SKTexture(imageNamed: "nextButtonSelected"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.nextButtonAction))
        button.position = CGPoint(x: 350,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: button.size.width * 3, height: button.size.height * 3)
        button.name = "nextButton"
        return button
    }()
    
    lazy var backButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "backButton"), selectedTexture: SKTexture(imageNamed: "backButtonSelected"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.backButtonAction))
        button.position = CGPoint(x: 200,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: button.size.width * 3, height: button.size.height * 3)
        button.name = "backButton"
        return button
    }()
    
    lazy var endButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "endButton"), selectedTexture: SKTexture(imageNamed: "endButton"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.endChallengeAction))
        button.position = CGPoint(x: 0,y: -250)
        button.zPosition = 3
        button.size = CGSize(width: button.size.width * 3, height: button.size.height * 3)
        button.name = "endButton"
        return button
    }()
    
    init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is StartState.Type ? true : false
    }
    
    override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        createAllMessages()
        
        scene.addChild(youNode)
        scene.addChild(anaNode)
    }
    
    override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
        backButton.isHidden = false
        nextButton.isHidden = false
    }
    
    func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    @objc func endChallengeAction() {
        self.gameScene.gameState.enter(StartState.self)
    }
    
}

// MARK: - Messages logic
extension FinalState: MessageDelegate {
    func lastMessageTapped() {
        print("acabaram as mensagens")
        scene.addChild(endButton)
        backButton.isHidden = true
        nextButton.isHidden = true
    }
    
    @objc func nextButtonAction() {
        self.msg.nextMessage()
    }
    
    @objc func backButtonAction() {
        self.msg.previousMessage()
    }
    
    func createAllMessages() {
        msg = Message(fontNamed: "Helvetica")
        msg.messages = FinalStateConstants.messages
        msg.position = CGPoint(x: 0,y: 300)
        msg.numberOfLines = 3
        msg.horizontalAlignmentMode = .center
        msg.verticalAlignmentMode = .center
        msg.fontSize = 50
        msg.delegate = self
        
        scene.addChild(msg)
        scene.addChild(nextButton)
        scene.addChild(backButton)
        
    }
}




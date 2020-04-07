//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class StartState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var messages: [Message] = []
    var atualIndexMessage = 0
    
    lazy var groupNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "group")
        node.name = "groupNode"
        node.position = CGPoint(x: 0, y: 0)
        node.zPosition = 2
        return node
    }()
    
    lazy var youNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "you")
        node.name = "groupNode"
        node.position = CGPoint(x: -50, y: 0)
        node.zPosition = 2
        return node
    }()
    
    lazy var anaNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "ana")
        node.name = "groupNode"
        node.position = CGPoint(x: 50, y: 0)
        node.zPosition = 2
        return node
    }()
    
    
    lazy var nextButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "nextButton"), selectedTexture: SKTexture(imageNamed: "nextButtonSelected"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.nextButtonAction))
        button.position = CGPoint(x: 350,y: -300)
        button.zPosition = 3
        button.name = "nextButton"
        return button
    }()
    
    lazy var backButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "backButton"), selectedTexture: SKTexture(imageNamed: "backButtonSelected"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.backButtonAction))
        button.position = CGPoint(x: 200,y: -300)
        button.zPosition = 3
        button.name = "backButton"
        return button
    }()
    
    lazy var startButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "iniciarButton"), selectedTexture: SKTexture(imageNamed: "iniciarButton"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.startButtonAction))
        button.position = CGPoint(x: 0,y: -300)
        button.zPosition = 3
        button.name = "emphatyButton"
        return button
    }()
    
    
    public init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
    
    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is InitialState.Type ? true : false
    }
    
    public override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        
        let msg = Message(fontNamed: "Helvetica")
        msg.messages = [StartStateConstants.initialMessage]
        msg.position = CGPoint(x: 0,y: 320)
        msg.numberOfLines = 3
        msg.horizontalAlignmentMode = .center
        msg.verticalAlignmentMode = .center
        msg.fontSize = 100
        
        scene.addChild(msg)
        scene.addChild(startButton)
        scene.addChild(groupNode)
    }
    
    
    public override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
        atualIndexMessage = 0
    }
    
    public func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    
    @objc public func startButtonAction() {
        groupNode.removeFromParent()
        scene.removeAllChildren()
        scene.addChild(anaNode)
        scene.addChild(youNode)
        createAllMessages()
    }
    
    
    
}

// MARK: - Messages logic
extension StartState: MessageDelegate {
    public func lastMessageTapped() {
        print("acabaram as mensagens")
        self.gameScene.gameState.enter(InitialState.self)
    }
    
    @objc public  func nextButtonAction() {
        self.messages[atualIndexMessage].nextMessage()
    }
    
    @objc public func backButtonAction() {
        self.messages[atualIndexMessage].previousMessage()
        
    }
    
    public func createAllMessages() {
        let msg = Message(fontNamed: "Helvetica")
        msg.messages = StartStateConstants.messages
        msg.position = CGPoint(x: 0,y: 320)
        msg.numberOfLines = 3
        msg.horizontalAlignmentMode = .center
        msg.verticalAlignmentMode = .center
        msg.delegate = self
        msg.fontSize = 50
        messages.append(msg)
        
        scene.addChild(msg)
        scene.addChild(nextButton)
        scene.addChild(backButton)
    }
}






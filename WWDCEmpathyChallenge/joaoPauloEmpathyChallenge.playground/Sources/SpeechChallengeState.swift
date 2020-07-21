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
    public var bubbles: [Card] = []
    public var msg: Message!
    public var bubblesTouchedQuantity = 0 {
        didSet {
            if bubblesTouchedQuantity == SpeechConstants.bubbles.count {
                endChallenge()
            }
        }
    }
    
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
        node.position = CGPoint(x: 150, y: -200)
        node.zPosition = 2
        return node
    }()
    
    lazy var spceechIconNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "speechIcon")
        node.name = "spceechIconNode"
        node.position = CGPoint(x: -450, y: 350)
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
    
    lazy var answerCircle: ClickElement = {
        let shape = ClickElement(circleOfRadius: 50)
        shape.id = 0
        shape.name = "clickElement"
        shape.position = CGPoint(x: 350, y: 150)
        shape.fillColor = .green
        shape.lineWidth = 0
        shape.isHidden = true
        //        shape.delegate = self
        return shape
    }()
    
    lazy var answerMessage: Message = {
        let txt = Message(fontNamed: "Helvetica")
        txt.messages = SpeechStateConstants.answerMessages
        txt.position = CGPoint(x: 50 ,y: 150)
        txt.numberOfLines = 3
        txt.horizontalAlignmentMode = .center
        txt.verticalAlignmentMode = .center
        txt.fontSize = 40
        txt.isHidden = true
        
        return txt
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
        
        scene.addChild(answerCircle)
        scene.addChild(answerMessage)
        
        let title = Message(fontNamed: "Helvetica")
        title.messages = [SpeechStateConstants.initialMessage]
        title.position = CGPoint(x: -180 ,y: 350)
        title.numberOfLines = 3
        title.horizontalAlignmentMode = .center
        title.verticalAlignmentMode = .center
        title.fontSize = 50
        scene.addChild(spceechIconNode)
        scene.addChild(title)
        
        createAllMessages()
        
        
    }
    
    public override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
        self.bubbles = []
        self.bubblesTouchedQuantity = 0
    }
    
    public func startChallenge() {
        scene.addChild(speechBubbleNode)
        
        createBubbles()
        addAllChildren()
        
    }
    
    public func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    public func createBubbles() {
        for i in 0..<SpeechConstants.bubbles.count {
            let bubble = Card(imageNamed: SpeechConstants.bubbles[i].imageName)
            bubble.id = SpeechConstants.bubbles[i].id
            bubble.name = SpeechConstants.bubbles[i].imageName
            bubble.position = SpeechConstants.bubbles[i].position
            bubble.zPosition = 4
            bubble.correctSoundName = SpeechConstants.bubbles[i].audioName
            bubble.delegate = self
            bubble.pulse()
            bubbles.append(bubble)
        }
    }
    
    public func addAllChildren() {
        for bubble in bubbles {
            scene.addChild(bubble)
        }
    }
    
    @objc public func speakButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
    
    public func endChallenge() {
        print("Speech Challenge Ended")
        self.scene.run(.sequence([
            .wait(forDuration: 1),
            .run {self.gameScene.gameState.enter(InitialState.self)}
        ]))
    }
    
}

// MARK: - SpeechChallengeLogic
extension SpeechChallengeState: CardDelegate {
    
    public func didTouched(element: Card) {
        let actions: [SKAction] = [
            .run {
                let action = SKAction.move(to: SpeechConstants.newLocation, duration: 2)
                element.run(action)
                self.bubbles.forEach({
                    $0.isUserInteractionEnabled = false
                   
                })
            },
            .wait(forDuration: 2),
            .playSoundFileNamed(element.correctSoundName!, waitForCompletion: true),
            .run { self.showAnswerCircle(element.id) },
            .run {
                element.removeFromParent()
                self.bubbles.forEach({
                    $0.isUserInteractionEnabled = true
                })
            }
        ]
        scene.run(.sequence(actions))
    }
    
    public func showAnswerCircle(_ id: Int) {
        answerCircle.fillColor = id == 0 ? .red : .green
        
        self.scene.run(.sequence([
            .run {
                self.answerCircle.isHidden = false
                self.answerMessage.isHidden = false
                self.answerMessage.text = SpeechStateConstants.answerMessages[id]
            },
            .wait(forDuration: 5),
            .run {
                self.answerCircle.isHidden = true
                self.answerMessage.isHidden = true
                self.bubblesTouchedQuantity += 1
            }
        ]))
    }
}

// MARK: - Messages logic
extension SpeechChallengeState: MessageDelegate {
    public func lastMessageTapped() {
        msg.removeFromParent()
        backButton.removeFromParent()
        nextButton.removeFromParent()
        startChallenge()
    }
    
    @objc public func nextButtonAction() {
        self.msg.nextMessage()
    }
    
    @objc public func backButtonAction() {
        self.msg.previousMessage()
    }
    
    public func createAllMessages() {
        msg = Message(fontNamed: "Helvetica")
        msg.messages = SpeechStateConstants.messages
        msg.position = CGPoint(x: 0,y: 0)
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


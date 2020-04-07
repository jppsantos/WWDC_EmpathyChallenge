//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class InitialState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var messages: [Message] = []
    public var atualIndexMessage = 0 {
        didSet {
            if atualIndexMessage == 3 {
                endButton.pulse()
                scene.addChild(endButton)
            }
        }
    }
    public var buttonsArray: [SKButtonNode] = []
    
    public enum AtualChallenge {
        case none
        case sound
        case empathy
        case speech
    }
    
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
    
    lazy var endButton: SKButtonNode = {
           let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "helpAnaButton"), selectedTexture: SKTexture(imageNamed: "helpAnaButton"), disabledTexture: SKTexture(imageNamed: ""))
           button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.endButtonAction))
           button.position = CGPoint(x: 0,y: -190)
           button.zPosition = 3
           button.name = "backButton"
           return button
       }()
    
    
    public init(_ gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }
    
    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
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
    
    public override func didEnter(from previousState: GKState?) {
        controlNode = gameScene.controlNode
        scene = buildScene()
        controlNode.addChild(scene)
        addButtonsInArray()
        setAtualIndexMessage(from: previousState)
        
        scene.addChild(youNode)
        scene.addChild(anaNode)
        
        scene.addChild(soundButton)
        scene.addChild(speechButton)
        scene.addChild(empathyButton)
        
        createAllMessages()
        
    }
    
    
    public override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
        self.atualIndexMessage = 0
    }
    
    public func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    @objc public func soundButtonAction() {
        self.gameScene.gameState.enter(SoundChallengeState.self)
    }
    
    @objc public func speakButtonAction() {
        self.gameScene.gameState.enter(SpeechChallengeState.self)
    }
    
    @objc public func empathyButtonAction() {
        self.gameScene.gameState.enter(EmpathyChallengeState.self)
    }
    
    @objc public func endButtonAction() {
        self.gameScene.gameState.enter(FinalState.self)
    }
    
    public func addButtonsInArray() {
        buttonsArray.append(soundButton)
        buttonsArray.append(speechButton)
        buttonsArray.append(empathyButton)
    }
    
}

// MARK: - Messages logic
extension InitialState: MessageDelegate {
    public func lastMessageTapped() {
        print("acabaram as mensagens")
        if atualIndexMessage == 0 {
            setButtonsBy(.sound)
        }
    }
    
    @objc public func nextButtonAction() {
        self.messages[atualIndexMessage].nextMessage()
    }
    
    @objc public func backButtonAction() {
        self.messages[atualIndexMessage].previousMessage()
    }
    
    public func setAtualIndexMessage(from previousState: GKState?) {
        guard let previous = previousState else { return }
        switch previous {
        case is SoundChallengeState:
            atualIndexMessage = 1
            setButtonsBy(.empathy)
        case is EmpathyChallengeState:
            atualIndexMessage = 2
            setButtonsBy(.speech)
        case is SpeechChallengeState:
            atualIndexMessage = 3
            setButtonsBy(.none)
        default:
            atualIndexMessage = 0
            setButtonsBy(.none)
        }
    }
    
    public func createAllMessages() {
        
        let msg = Message(fontNamed: "Helvetica")
        msg.messages = InitialStateConstants.messages[atualIndexMessage].message
        msg.position = CGPoint(x: 0,y: 320)
        msg.numberOfLines = 3
        msg.horizontalAlignmentMode = .center
        msg.verticalAlignmentMode = .center
        msg.fontSize = 50
        msg.delegate = self
        messages.append(msg)
        
        scene.addChild(msg)
        if !(atualIndexMessage == 3) {
            scene.addChild(nextButton)
            scene.addChild(backButton)
        }
        
    }
    
    public func setButtonsBy(_ atualChallenge: AtualChallenge) {
        
        switch atualChallenge {
        case .none:
            buttonsArray.forEach {
                $0.removeAllActions()
                $0.isUserInteractionEnabled = false
                $0.pausePulse()
            }
        case .sound:
            buttonsArray.forEach {
                if ($0.name == soundButton.name) {
                    $0.isUserInteractionEnabled = true
                    $0.pulse()
                    $0.isSelected = true
                } else {
                    $0.pausePulse()
                    $0.isUserInteractionEnabled = false
                    $0.isSelected = false
                }
            }
        case .speech:
            buttonsArray.forEach {
                if ($0.name == speechButton.name) {
                    $0.isUserInteractionEnabled = true
                    $0.pulse()
                    $0.isSelected = true
                } else {
                    $0.pausePulse()
                    $0.isUserInteractionEnabled = false
                    $0.isSelected = false
                }
            }
        default:
            buttonsArray.forEach {
                if ($0.name == empathyButton.name) {
                    $0.isUserInteractionEnabled = true
                    $0.pulse()
                    $0.isSelected = true
                } else {
                    $0.pausePulse()
                    $0.isUserInteractionEnabled = false
                    $0.isSelected = false
                }
            }
        }
    }
}






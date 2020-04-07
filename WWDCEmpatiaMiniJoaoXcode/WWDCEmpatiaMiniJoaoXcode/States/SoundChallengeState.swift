//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class SoundChallengeState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var shapes: [ClickElement] = []
    var atualLevel = 0 {
        didSet {
            if atualLevel == Levels.levels.count {
                endChallenge()
            }
        }
    }
    var sequence: [Int]!
    var msg: Message!
    
    
    var atualIndex = 0 {
        didSet {
            if atualIndex == Levels.levels[atualLevel].sequence.count {
                endLevel(withSuccess: true)
            }
        }
    }
    
    lazy var soundButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture:    SKTexture(imageNamed: "soundButtonNormal"),
                                  selectedTexture:    SKTexture(imageNamed: "soundButtonSelected"),
                                  disabledTexture:    SKTexture(imageNamed: "soundButtonDisabled"))
        button.setButtonAction(target: self,
                               triggerEvent: .TouchUpInside,
                               action: #selector(self.soundButtonAction))
        button.position = CGPoint(x: -420,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: 150, height: 150)
        button.name = "soundButton"
        return button
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
    
    lazy var raplayButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "replayButton"), selectedTexture: SKTexture(imageNamed: "replayButtonSelected"), disabledTexture: SKTexture(imageNamed: ""))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.raplayButtonAction))
        button.position = CGPoint(x: -400,y: -300)
        button.zPosition = 3
        button.size = CGSize(width: button.size.width * 3, height: button.size.height * 3)
        button.name = "backButton"
        return button
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
        //        scene.addChild(soundButton)
        
        
        createAllMessages()
        
    }
    
    override func willExit(to nextState: GKState) {
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.controlNode = nil
        self.scene = nil
    }
    
    func startChallenge() {
        buildLevel()
    }
    
    func buildScene() -> SKSpriteNode {
        let node = SKSpriteNode()
        node.color = UIColor(hex: 0x8BC7EB)
        node.size = gameScene.size
        node.zPosition = 1
        node.name = "initialScene"
        return node
    }
    
    func buildLevel(){
        if !(atualLevel == Levels.levels.count) {
            for i in 0..<Levels.levels[atualLevel].elementQuantity {
                let shape = ClickElement(circleOfRadius: 50)
                shape.id = i
                shape.name = "clickElement"
                shape.position = Levels.levels[atualLevel].positions[i]
                shape.fillColor = Levels.levels[atualLevel].colors[i]
                shape.delegate = self
                scene.addChild(shape)
                shapes.append(shape)
            }
            sequence = Levels.levels[atualLevel].sequence
            
            scene.run(.sequence([
                .wait(forDuration: 2),
                .run {self.play(challengeSequence: self.sequence)},
                .run { self.scene.addChild(self.raplayButton) }
            ]))
            
        }
    }
    
    func play(challengeSequence: [Int]){
        var actions: [SKAction] = []
        
        for id in challengeSequence {
            guard let element = shapes.filter({ $0.id == id }).first else {return}
            actions.append(.run {element.correctClick()})
            actions.append(.wait(forDuration: 1))
        }
        
        scene.run(.sequence(actions))
    }
    
    func pauseChallenge(){
        print("Pausando o jogo rapaziada")
    }
    
    func endLevel(withSuccess: Bool = false) {
            if withSuccess {
                print("Parabens abestato!")
                atualIndex = 0
                atualLevel += 1
                shapes.forEach({$0.removeFromParent()})
                shapes = []
                buildLevel()
                self.raplayButton.removeFromParent()
            } else {
                print("Deu ruim pra tu")
            }
    }
    
    func endChallenge() {
        self.gameScene.gameState.enter(InitialState.self)
    }
    
    @objc func raplayButtonAction() {
        play(challengeSequence: self.sequence)
    }
    
    @objc func soundButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
}



extension SoundChallengeState: ClickElementDelegate {
    func didTouched(element: ClickElement) {
        if Levels.levels[atualLevel].sequence[atualIndex] == element.id {
            element.correctClick()
            atualIndex += 1
        } else {
            element.wrongClick()
            endLevel()
        }
    }
}


// MARK: - Messages logic
extension SoundChallengeState: MessageDelegate {
    func lastMessageTapped() {
        print("acabaram as mensagens")
        startChallenge()
        msg.removeFromParent()
        backButton.removeFromParent()
        nextButton.removeFromParent()
    }
    
    @objc func nextButtonAction() {
        self.msg.nextMessage()
    }
    
    @objc func backButtonAction() {
        self.msg.previousMessage()
    }
    
    func createAllMessages() {
        msg = Message(fontNamed: "Helvetica")
        msg.messages = SoundStateConstants.messages
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



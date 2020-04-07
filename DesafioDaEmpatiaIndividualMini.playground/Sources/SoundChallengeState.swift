//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class SoundChallengeState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var shapes: [ClickElement] = []
    var atualLevel = 0
    var sequence: [Int]!
    
    
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
        scene.addChild(soundButton)
        sequence = Levels.levels[atualLevel].sequence
        
        
        buildLevel()
        
        scene.run(.sequence([
                    .wait(forDuration: 2),
                    .run {self.play(challengeSequence: self.sequence)}
                ]))
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
    
    public func buildLevel(){
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
    }
    
    public func play(challengeSequence: [Int]){
        var actions: [SKAction] = []
        
        for id in challengeSequence {
            guard let element = shapes.filter({ $0.id == id }).first else {return}
            actions.append(.run {element.correctClick()})
            actions.append(.wait(forDuration: 1))
        }
        
        scene.run(.sequence(actions))
    }
    
    public func pauseChallenge(){
        print("Pausando o jogo rapaziada")
    }
    
    public func endLevel(withSuccess: Bool = false) {
        if withSuccess {
            print("Parabens abestato!")
            atualIndex = 0
        } else {
            print("Deu ruim pra tu")
        }
    }
   
    @objc public func soundButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
}



extension SoundChallengeState: ClickElementDelegate {
    public func didTouched(element: ClickElement) {
        if Levels.levels[atualLevel].sequence[atualIndex] == element.id {
            element.correctClick()
            atualIndex += 1
        } else {
            element.wrongClick()
            endLevel()
        }
    }
}



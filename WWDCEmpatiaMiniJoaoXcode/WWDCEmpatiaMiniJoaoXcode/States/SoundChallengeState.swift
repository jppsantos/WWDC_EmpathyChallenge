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
    var level = 0
    var sequence = [0,1,2,2,1]
    
    
    var atualIndex = 0 {
        didSet {
            if atualIndex == sequence.count {
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
        scene.addChild(soundButton)
        
        buildLevel1()
        
        scene.run(.sequence([
                    .wait(forDuration: 5),
                    .run {self.play(challengeSequence: self.sequence)}
                ]))
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
    
    func buildLevel(){
        for i in 0..<Levels.levels[level].elementQuantity {
            let shape = ClickElement(circleOfRadius: 50)
            shape.id = i
            shape.name = "clickElement"
            shape.position = Levels.levels[level].positions[i]
            shape.fillColor = Levels.levels[level].colors[i]
            shape.delegate = self
            scene.addChild(shape)
            shapes.append(shape)
        }
    }
    
 
    func buildLevel1(){
        for i in 0..<3 {
            let shape = ClickElement(circleOfRadius: 50)
            shape.id = i
            shape.name = "clickElement"
            shape.position = SoundPositions.Level1Positions.array[i]
            shape.fillColor = SoundColors.Level1Colors.array[i]
            shape.delegate = self
            scene.addChild(shape)
            shapes.append(shape)
        }
    }
    
    func buildLevel2(){
        for i in 0..<4 {
            let shape = ClickElement(circleOfRadius: 50)
            shape.id = i
            shape.name = "clickElement"
            shape.position = SoundPositions.Level1Positions.array[i]
            shape.fillColor = SoundColors.Level1Colors.array[i]
            shape.delegate = self
            scene.addChild(shape)
            shapes.append(shape)
        }
    }
    
    func buildLevel3(){
        for i in 0..<6 {
            let shape = ClickElement(circleOfRadius: 50)
            shape.id = i
            shape.name = "clickElement"
            shape.position = SoundPositions.Level3Positions.array[i]
            shape.fillColor = SoundColors.Level3Colors.array[i]
            shape.delegate = self
            scene.addChild(shape)
            shapes.append(shape)
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
        } else {
            print("Deu ruim pra tu")
        }
    }
   
    @objc func soundButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
}



extension SoundChallengeState: ClickElementDelegate {
    func didTouched(element: ClickElement) {
        if sequence[atualIndex] == element.id {
            element.correctClick()
            atualIndex += 1
        } else {
            element.wrongClick()
            endLevel()
        }
    }
}



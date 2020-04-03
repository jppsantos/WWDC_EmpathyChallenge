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
    
    lazy var soundButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture:   SKTexture(imageNamed: "soundButtonNormal"),
                                  selectedTexture: SKTexture(imageNamed: "soundButtonSelected"),
                                  disabledTexture: SKTexture(imageNamed: "soundButtonDisabled"))
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

    }

    public override func willExit(to nextState: GKState) {
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
    
    @objc public  func soundButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
    
}

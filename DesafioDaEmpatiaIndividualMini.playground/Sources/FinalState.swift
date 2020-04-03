//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class FinalState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    
    public init(_ gameScene: GameScene) {
           self.gameScene = gameScene
           super.init()
    }
    
    public override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }
    
    public override func didEnter(from previousState: GKState?) {
           controlNode = gameScene.controlNode
           scene = buildScene()
           controlNode.addChild(scene)
           
       }
       
       public override func willExit(to nextState: GKState) {
           self.scene.removeAllChildren()
           self.scene.removeFromParent()
           self.controlNode = nil
           self.scene = nil
       }
       
       func buildScene() -> SKSpriteNode {
           let node = SKSpriteNode()
           node.color = UIColor(red: 139, green: 199, blue: 235, alpha: 1)
           node.size = gameScene.size
           node.zPosition = 1
           node.name = "initialScene"
           return node
       }
    
}


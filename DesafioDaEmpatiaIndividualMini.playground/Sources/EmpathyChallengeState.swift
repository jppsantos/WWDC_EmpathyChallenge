//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

public class EmpathyChallengeState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    
    lazy var empathyButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "empathyButtonNormal"), selectedTexture: SKTexture(imageNamed: "empathyButtonSelected"), disabledTexture: SKTexture(imageNamed: "empathyButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.empathyButtonAction))
        button.position = EmpathyPositions.empathyButtonPosition
        button.zPosition = 3
        button.size = CGSize(width: 150, height: 150)
        button.name = "speakButton"
        return button
    }()
    
    lazy var empathyBubbleAna: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "empathyBubbleAna")
          node.name = "empathyBubbleAna"
        node.position = EmpathyPositions.empathyBubbleAna
          node.zPosition = 2
          return node
    }()
    
    lazy var empathyBubbleYou: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "empathyBubbleYou")
          node.name = "empathyBubbleYou"
        node.position = EmpathyPositions.empathyBubbleYou
          node.zPosition = 2
          return node
    }()
    
    lazy var dogCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "dogCard")
          node.name = "dogCard"
        node.position = EmpathyPositions.dogCard
          node.zPosition = 3
          return node
    }()
    
    lazy var houseCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "houseCard")
          node.name = "houseCard"
        node.position = EmpathyPositions.houseCard
          node.zPosition = 3
          return node
    }()
    
    lazy var peopleCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "peopleCard")
          node.name = "peopleCard"
        node.position = EmpathyPositions.peopleCard
          node.zPosition = 3
          return node
    }()
    
    lazy var moneyCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "moneyCard")
          node.name = "moneyCard"
          node.position = EmpathyPositions.moneyCard
          node.zPosition = 3
          return node
    }()
    
    lazy var heartCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "heartCard")
          node.name = "heartCard"
          node.position = EmpathyPositions.heartCard
          node.zPosition = 3
          return node
    }()
    
    lazy var carCard: SKSpriteNode = {
          let node = SKSpriteNode(imageNamed: "carCard")
          node.name = "carCard"
          node.position = EmpathyPositions.carCard
          node.zPosition = 3
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
        addAllChildren()
    }

    public override func willExit(to nextState: GKState) {
        self.empathyBubbleYou.removeAllChildren()
        self.empathyBubbleYou.removeFromParent()
        self.empathyBubbleAna.removeAllChildren()
        self.empathyBubbleAna.removeFromParent()
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
    
    func addAllChildren(){
        scene.addChild(empathyButton)
        scene.addChild(empathyBubbleAna)
        scene.addChild(empathyBubbleYou)
        
        empathyBubbleAna.addChild(dogCard)
        empathyBubbleAna.addChild(houseCard)
        empathyBubbleAna.addChild(peopleCard)
        empathyBubbleAna.addChild(moneyCard)
        empathyBubbleAna.addChild(carCard)
        empathyBubbleAna.addChild(heartCard)
        
        empathyBubbleYou.addChild(dogCard.copy() as! SKNode)
        empathyBubbleYou.addChild(houseCard.copy() as! SKNode)
        empathyBubbleYou.addChild(peopleCard.copy() as! SKNode)
        empathyBubbleYou.addChild(moneyCard.copy() as! SKNode)
        empathyBubbleYou.addChild(carCard.copy() as! SKNode)
        empathyBubbleYou.addChild(heartCard.copy() as! SKNode)
    }
    
    func touchesBegan(location: CGPoint) {
     
       guard let node = scene.nodes(at: location).first as? SKNode else {return}
        if !(node.self is SKButtonNode) {
            node.run(.rotate(byAngle: 45, duration: 3))
       }
    }
    
    @objc public func empathyButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
}

struct EmpathyPositions {
    static let empathyButtonPosition =  CGPoint(x: -420,y:  -300)
    static let empathyBubbleAna  =      CGPoint(x: -200,y:  -100)
    static let empathyBubbleYou =       CGPoint(x:  200, y: -100)
    
    static let dogCard =    CGPoint(x:  120,y: 60 + 150)
    static let houseCard =  CGPoint(x: -120,y: 60 + 150)
    static let peopleCard = CGPoint(x:    0,y: 60 + 150)
    static let moneyCard =  CGPoint(x:    0,y:-60 + 150)
    static let heartCard =  CGPoint(x:  120,y:-60 + 150)
    static let carCard =    CGPoint(x: -120,y:-60 + 150)
}


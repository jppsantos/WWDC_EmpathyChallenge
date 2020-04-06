//
//  InitialState1.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class EmpathyChallengeState: GKState {
    unowned let gameScene: GameScene
    var controlNode: SKNode!
    var scene: SKSpriteNode!
    var cards: [Card] = []
    var lastCardTouched: Card?
    
    
    var hitsQuantity = 0 {
        didSet {
            if hitsQuantity == EmpathyConstants.cards.count {
                endChallenge()
                cancelCardsInteraction(.left)
                cancelCardsInteraction(.right)
            }
        }
    }
    
    
    
    lazy var empathyButton: SKButtonNode = {
        let button = SKButtonNode(normalTexture: SKTexture(imageNamed: "empathyButtonNormal"), selectedTexture: SKTexture(imageNamed: "empathyButtonSelected"), disabledTexture: SKTexture(imageNamed: "empathyButtonDisabled"))
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(self.empathyButtonAction))
        button.position = EmpathyConstants.empathyButtonPosition
        button.zPosition = 3
        button.size = CGSize(width: 150, height: 150)
        button.name = "speakButton"
        return button
    }()
    
    lazy var empathyBubbleAna: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "empathyBubbleAna")
        node.name = "empathyBubbleAna"
        node.position = EmpathyConstants.empathyBubbleAnaPosition
        node.zPosition = 2
        node.size = CGSize(width: node.size.width * 3, height: node.size.height * 3)
        return node
    }()
    
    lazy var empathyBubbleYou: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "empathyBubbleYou")
        node.name = "empathyBubbleYou"
        node.position = EmpathyConstants.empathyBubbleYouPosition
        node.zPosition = 2
        node.size = CGSize(width: node.size.width * 3, height: node.size.height * 3)
        return node
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
        createCards()
        addAllChildren()
        
        self.scene.run(.sequence([.wait(forDuration: 1),
                                  .run {self.cards.forEach{$0.changeFace()}}]))
    }
    
    override func willExit(to nextState: GKState) {
        self.empathyBubbleYou.removeAllChildren()
        self.empathyBubbleYou.removeFromParent()
        self.empathyBubbleAna.removeAllChildren()
        self.empathyBubbleAna.removeFromParent()
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.cards = []
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
    
    func createCards(){
        var card: Card!
        var indexes: [Int] = []
        
        for i in 0..<EmpathyConstants.cards.count {
            card = Card(imageNamed: EmpathyConstants.cards[i].imageName)
            card.name = EmpathyConstants.cards[i].imageName
            card.position = EmpathyConstants.cards[i].position
            card.zPosition = 3
            card.size = CGSize(width: card.size.width * 3, height: card.size.height * 3)
            card.id = i
            card.delegate = self
            card.cardSide = .right
            cards.append(card)
            indexes.append(i)
        }
        
        for card in cards {
            guard let randomIndex = indexes.randomElement() else { return }
            indexes = indexes.filter{ $0 != randomIndex }
            card.position = EmpathyConstants.cards[randomIndex].position
        }
    }
    
    func addAllChildren(){
        scene.addChild(empathyButton)
        scene.addChild(empathyBubbleAna)
        scene.addChild(empathyBubbleYou)
        var cardCopies: [Card] = []
        var indexes: [Int] = []
        
        for card in cards {
            empathyBubbleAna.addChild(card)
        }
        
        for card in cards {
            let cardAux: Card = card.copy() as! Card
            cardAux.id = card.id
            card.cardSide = .left
            cardAux.delegate = self
            cardCopies.append(cardAux)
            cards.append(cardAux)
            empathyBubbleYou.addChild(cardAux)
            indexes.append(cardAux.id)
        }
        
        for card in cardCopies {
           guard let randomIndex = indexes.randomElement() else { return }
           indexes = indexes.filter{ $0 != randomIndex }
           card.position = EmpathyConstants.cards[randomIndex].position
        }
    }
    
    
    @objc func empathyButtonAction() {
        self.gameScene.gameState.enter(InitialState.self)
    }
}

//MARK: - MemoryEmpathtGameLogic
extension EmpathyChallengeState: CardDelegate {
    func didTouched(element: Card) {
        element.changeFace()
        let side = element.cardSide == CardSide.left ? CardSide.left : CardSide.right
        cancelCardsInteraction(side)
        if let lastTouched = lastCardTouched {
            compareCards(element, lastTouched)
            lastCardTouched = nil
        } else {
            lastCardTouched = element
        }
    }
    
    func cancelCardsInteraction(_ inSide: CardSide){
        switch inSide {
        case .left:
            empathyBubbleAna.children.forEach { $0.isUserInteractionEnabled = false }
        case .right:
            empathyBubbleYou.children.forEach { $0.isUserInteractionEnabled = false }
        default:
            empathyBubbleYou.children.forEach {
                let thisCard = $0 as! Card
                if !thisCard.isClosed {
                    thisCard.isUserInteractionEnabled = true
                }
            }
            empathyBubbleAna.children.forEach {
                let thisCard = $0 as! Card
                if !thisCard.isClosed {
                    thisCard.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    func compareCards(_ first: Card, _ second: Card) {
        if first.id == second.id {
            correctMatch()
            first.isUserInteractionEnabled = false
            first.isClosed = true
            second.isUserInteractionEnabled = false
            second.isClosed = true
            cancelCardsInteraction(.none)
            
            scene.run(.sequence([
                .wait(forDuration: 0.5),
                .run {
                    first.correctClick()
                    second.correctClick()
                }
            ]))
            
        } else {
            wrongMatch()
            scene.run(.sequence([
                .wait(forDuration: 0.5),
                .run {
                    first.wrongClick()
                    second.wrongClick()
                    },
                .wait(forDuration: 0.5),
                .run {
                    first.changeFace()
                    second.changeFace()
                }
            ]))
            cancelCardsInteraction(.none)
        }
    }
    
    func correctMatch(){
        print("Acertou esse em!")
        hitsQuantity += 1
    }
    
    func wrongMatch(){
        print("Errou esse em!")
    }
    
    func endChallenge(){
        print("Acabou o jogo miseravi")
    }
}



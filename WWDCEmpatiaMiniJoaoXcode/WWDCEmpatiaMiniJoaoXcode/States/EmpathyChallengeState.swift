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
    var msg: Message!
    
    
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
        
        createAllMessages()
        
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
    
    func startChallenge() {
        createCards()
        addAllChildren()
        
        self.scene.run(.sequence([.wait(forDuration: 1),
                                  .run {self.cards.forEach{$0.changeFace()}}]))
    }
    
    func createCards(){
        var card: Card!
        var indexes: [Int] = []
        
        for i in 0..<EmpathyConstants.cards.count {
            card = Card(imageNamed: EmpathyConstants.cards[i].imageName)
            card.name = EmpathyConstants.cards[i].imageName
            card.position = EmpathyConstants.cards[i].position
            card.zPosition = 3
            card.size = CGSize(width: card.size.width, height: card.size.height)
            card.id = i
            card.delegate = self
            card.cardSide = .right
            card.size = CGSize(width: card.size.width * 3, height: card.size.height * 3)
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

// MARK: - Messages logic
extension EmpathyChallengeState: MessageDelegate {
    func lastMessageTapped() {
        print("acabaram as mensagens")
        msg.removeFromParent()
        backButton.removeFromParent()
        nextButton.removeFromParent()
        startChallenge()
    }
    
    @objc func nextButtonAction() {
        self.msg.nextMessage()
    }
    
    @objc func backButtonAction() {
        self.msg.previousMessage()
    }
    
    func createAllMessages() {
        msg = Message(fontNamed: "Helvetica")
        msg.messages = EmpathyStateConstants.messages
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




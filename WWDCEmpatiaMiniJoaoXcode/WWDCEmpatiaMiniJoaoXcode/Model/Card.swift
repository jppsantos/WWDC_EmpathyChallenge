//
//  Card.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 04/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//
import SpriteKit

protocol CardDelegate {
    func didTouched(element: Card)
}

enum CardSide {
   case left
   case right
   case none
}

class Card: SKSpriteNode {
    var id: Int!
    var correctSoundName: String?
    var wrongSoundName: SKAudioNode?
    
    var action: Selector?
    weak var target: AnyObject?
    var delegate: CardDelegate?
    var otherFace: SKTexture? = SKTexture(imageNamed: "defaultCard")
    
    var isClosed: Bool = false
    var cardSide: CardSide?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override init(texture: SKTexture?, color: UIColor, size: CGSize = CGSize(width: 50, height: 50)) {
//        super.init(texture: texture, color: color, size: size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func correctClick(){
        let action = SKAction.sequence([.scale(to: 2.0, duration: 0.25),
                                        .playSoundFileNamed(correctSoundName ?? "", waitForCompletion: false),
                                        .scale(to: 1, duration: 0.25)])
        self.run(action)
    }
    
    func wrongClick(){
        self.run(SKAction.shake())
    }
    
    func changeFace(){
        let action = SKAction.sequence([
            .scaleX(to: -1, duration: 0.25),
            .run {
                let aux = self.texture
                self.texture = self.otherFace
                self.otherFace = aux
            },
            .scaleX(to: 1, duration: 0.25)
        ])
        self.run(action)
    }

    /**
    * Taking a target object and adding an action that is triggered by a click event.
    */
    func setElementAction(target: AnyObject, action:Selector) {
        self.target = target
        self.action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTouched(element: self)
    }

}

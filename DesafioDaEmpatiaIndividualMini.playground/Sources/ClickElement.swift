//
//  ClickElement.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 03/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

public protocol ClickElementDelegate {
    func didTouched(element: ClickElement)
}

public class ClickElement: SKShapeNode {
    public var id: Int!
    public var correctSound: SKAudioNode?
    public var wrongSound: SKAudioNode?

    public var action: Selector?
    public weak var target: AnyObject?
    public var delegate: ClickElementDelegate?
    public var otherFace: SKTexture? = SKTexture(imageNamed: "defaultCard")
 
    public var isClosed: Bool = false
    
    public override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override init(texture: SKTexture?, color: UIColor, size: CGSize = CGSize(width: 50, height: 50)) {
//        super.init(texture: texture, color: color, size: size)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    public func correctClick(){
        let action = SKAction.sequence([.scale(to: 2.0, duration: 0.25),.playSoundFileNamed("Cartoon_Boing.mp3", waitForCompletion: false),.scale(to: 1, duration: 0.25)])
        self.run(action)
    }
    
    public func wrongClick(){
        self.run(SKAction.shake())
    }
    
    public func changeFace(){
        let action = SKAction.sequence([
            .scaleX(to: -25, duration: 0.25),
            .run {
                let aux = self.fillTexture
                self.fillTexture = self.otherFace
                self.otherFace = aux
            },
            .scaleX(to: 0, duration: 0.25)
        ])
        self.run(action)
    }

    /**
    * Taking a target object and adding an action that is triggered by a click event.
    */
    public func setElementAction(target: AnyObject, action:Selector) {
        self.target = target
        self.action = action
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("eu \(String(describing: id)) fui clicado")
        delegate?.didTouched(element: self)
    }

}


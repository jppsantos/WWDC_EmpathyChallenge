//
//  ClickElement.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 03/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

protocol ClickElementDelegate {
    func didTouched(element: ClickElement)
}

class ClickElement: SKShapeNode {
    var id: Int!
    var correctSound: SKAudioNode!
    var wrongSound: SKAudioNode!
    
    var action: Selector?
    weak var target: AnyObject?
    var delegate: ClickElementDelegate?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
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
        let action = SKAction.sequence([.scale(to: 2.0, duration: 0.25),.playSoundFileNamed("Cartoon_Boing.mp3", waitForCompletion: false),.scale(to: 1, duration: 0.25)])
        self.run(action)
    }
    
    func wrongClick(){
        self.run(SKAction.shake())
    }

    /**
    * Taking a target object and adding an action that is triggered by a click event.
    */
    func setElementAction(target: AnyObject, action:Selector) {
        self.target = target
        self.action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("eu \(String(describing: id)) fui clicado")
        delegate?.didTouched(element: self)
    }

}


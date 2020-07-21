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
    var correctSoundName: String?
    var wrongSoundName: String?
    
    var action: Selector?
    weak var target: AnyObject?
    var delegate: ClickElementDelegate?
    var otherFace: SKTexture? = SKTexture(imageNamed: "defaultCard")
    
    var isClosed: Bool = false
    
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
        let action = SKAction.sequence([.scale(to: 1.5, duration: 0.25),.playSoundFileNamed(correctSoundName ?? "boing.mp3", waitForCompletion: false),.scale(to: 1, duration: 0.25)])
        self.run(action)
    }
    
    func wrongClick(){
        self.run(SKAction.shake())
    }
    
    func changeFace(){
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
    func setElementAction(target: AnyObject, action:Selector) {
        self.target = target
        self.action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("eu \(String(describing: id)) fui clicado")
        delegate?.didTouched(element: self)
    }

}


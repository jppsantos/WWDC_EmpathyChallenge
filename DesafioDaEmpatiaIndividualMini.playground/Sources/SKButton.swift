//
//  SKButton.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 02/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

public class SKButtonNode: SKSpriteNode {

    public enum SKButtonActionType: Int {
        case TouchUpInside = 1,
        TouchDown, TouchUp
    }

    public var isEnabled: Bool = true {
        didSet {
            if (disabledTexture != nil) {
                texture = isEnabled ? defaultTexture : disabledTexture
            }
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            texture = isSelected ? selectedTexture : defaultTexture
        }
    }

    public var defaultTexture: SKTexture
    public var selectedTexture: SKTexture
    public var label: SKLabelNode

    public required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    public init(normalTexture defaultTexture: SKTexture!, selectedTexture:SKTexture!, disabledTexture: SKTexture?) {

        self.defaultTexture = defaultTexture
        self.selectedTexture = selectedTexture
        self.disabledTexture = disabledTexture
        self.label = SKLabelNode(fontNamed: "Helvetica");

        super.init(texture: defaultTexture, color: UIColor.white, size: defaultTexture.size())
        isUserInteractionEnabled = true

        //Creating and adding a blank label, centered on the button
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;
        addChild(self.label)

        // Adding this node as an empty layer. Without it the touch functions are not being called
        // The reason for this is unknown when this was implemented...?
        let bugFixLayerNode = SKSpriteNode(texture: nil, color: UIColor.clear, size: defaultTexture.size())
        bugFixLayerNode.position = self.position
        addChild(bugFixLayerNode)

    }

    /**
     * Taking a target object and adding an action that is triggered by a button event.
     */
    public func setButtonAction(target: AnyObject, triggerEvent event:SKButtonActionType, action:Selector) {

        switch (event) {
        case .TouchUpInside:
            targetTouchUpInside = target
            actionTouchUpInside = action
        case .TouchDown:
            targetTouchDown = target
            actionTouchDown = action
        case .TouchUp:
            targetTouchUp = target
            actionTouchUp = action
        }

    }

    public func setButtonLabel(title: NSString, font: String, fontSize: CGFloat) {
        self.label.text = title as String
        self.label.fontSize = fontSize
        self.label.fontName = font
    }

    public var disabledTexture: SKTexture?
    public var actionTouchUpInside: Selector?
    public var actionTouchUp: Selector?
    public var actionTouchDown: Selector?
    public weak var targetTouchUpInside: AnyObject?
    public weak var targetTouchUp: AnyObject?
    public weak var targetTouchDown: AnyObject?

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }
        isSelected = true
        if (targetTouchDown != nil && targetTouchDown!.responds(to: actionTouchDown)) {
            UIApplication.shared.sendAction(actionTouchDown!, to: targetTouchDown, from: self, for: nil)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        if (!isEnabled) {
            return
        }

        let touch: AnyObject! = touches.first
        let touchLocation = touch.location(in: parent!)

        if (frame.contains(touchLocation)) {
            isSelected = true
        } else {
            isSelected = false
        }

    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isEnabled) {
            return
        }

        isSelected = false

        if (targetTouchUpInside != nil && targetTouchUpInside!.responds(to: actionTouchUpInside!)) {
            let touch: AnyObject! = touches.first
            let touchLocation = touch.location(in: parent!)

            if (frame.contains(touchLocation) ) {
                UIApplication.shared.sendAction(actionTouchUpInside!, to: targetTouchUpInside, from: self, for: nil)
            }

        }

        if (targetTouchUp != nil && targetTouchUp!.responds(to: actionTouchUp!)) {
            UIApplication.shared.sendAction(actionTouchUp!, to: targetTouchUp, from: self, for: nil)
        }
    }

}

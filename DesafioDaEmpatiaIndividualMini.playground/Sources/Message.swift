//
//  CustomLabel.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 06/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//
import Foundation
import SpriteKit

public protocol MessageDelegate {
    func lastMessageTapped()
}

public class Message: SKLabelNode {
    
    public var delegate: MessageDelegate?
    public var messages: [String]? {
        didSet {
            guard let msgs = messages else {return}
            self.text = msgs.first
        }
    }
    
    public var atualMessageIndex: Int = 0 {
        didSet {
            guard let msgs = messages else {return}
            if atualMessageIndex == msgs.count {
                messagesEnded()
                atualMessageIndex = msgs.count - 1
            }
            if atualMessageIndex < 0 { atualMessageIndex = 0 }
        }
    }
    
    public func nextMessage() {
        atualMessageIndex += 1
        guard let msgs = messages else {return}
        self.text = msgs[atualMessageIndex]
    }
    
    public func previousMessage() {
        atualMessageIndex -= 1
        guard let msgs = messages else {return}
        self.text = msgs[atualMessageIndex]
    }
    
    public func messagesEnded(){
        delegate?.lastMessageTapped()
    }
}

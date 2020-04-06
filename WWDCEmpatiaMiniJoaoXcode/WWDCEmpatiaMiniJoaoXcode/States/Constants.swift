//
//  Constants.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

struct Level {
    var elementQuantity: Int = 0
    var positions: [CGPoint] = []
    var colors: [UIColor] = []
    var sequence: [Int] = []
    
    init(elementQuantity: Int, sequence: [Int], positions: [CGPoint], colors: [UIColor]) {
        self.elementQuantity = elementQuantity
        self.positions = positions
        self.colors = colors
        self.sequence = sequence
    }
}

struct Levels {
    static let levels: [Level] = [
        .init(
            elementQuantity: 3,
            sequence: [2,1,2,0,1],
            positions: [
                CGPoint(x: -150, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 150, y: 0)
            ],
            colors: [.red,.green,.blue]
        ),
        
        .init(
            elementQuantity: 4,
            sequence: [3,1,2,0,1,3],
            positions: [
                CGPoint(x: -100, y:  100),
                CGPoint(x:  100, y:  100),
                CGPoint(x: -100, y: -100),
                CGPoint(x:  100, y: -100),
            ],
            colors: [.red,.green,.blue,.purple]
        ),
        
        .init(
            elementQuantity: 6,
            sequence: [0,1,2,5,4,3],
            positions: [
                CGPoint(x: -150, y:   75),
                CGPoint(x:    0, y:  150),
                CGPoint(x:  150, y:   75),
                CGPoint(x:  150, y:  -75),
                CGPoint(x:    0, y: -150),
                CGPoint(x: -150, y:  -75),
            ],
            colors: [.red,.green,.blue,.purple,.cyan,.black]
        )
    ]
    
}

struct SoundColors {
    struct Level1Colors {
        static let array: [UIColor] = [.red,.green,.blue]
    }
    
    struct Level2Colors {
        static let array: [UIColor] = [.red,.green,.blue,.purple]
    }
    
    struct Level3Colors {
        static let array: [UIColor] = [.red,.green,.blue,.purple,.cyan,.black]
    }
}


struct CardModel {
    var imageName: String = ""
    var position = CGPoint()
    
    init(imageName: String, position: CGPoint) {
        self.imageName = imageName
        self.position = position
    }
}

struct EmpathyConstants {
    static let cards: [CardModel] = [
    .init(imageName: "dogCard",     position: CGPoint(x:  120,y: 60 + 150)),
    .init(imageName: "houseCard",   position: CGPoint(x: -120,y: 60 + 150)),
    .init(imageName: "peopleCard",  position: CGPoint(x:    0,y: 60 + 150)),
    .init(imageName: "moneyCard",   position: CGPoint(x:    0,y:-60 + 150)),
    .init(imageName: "heartCard",   position: CGPoint(x:  120,y:-60 + 150)),
    .init(imageName: "carCard",     position: CGPoint(x: -120,y:-60 + 150))
    ]
    
    static let empathyButtonPosition =          CGPoint(x: -420,y:  -300)
    static let empathyBubbleAnaPosition  =      CGPoint(x: -200,y:  -100)
    static let empathyBubbleYouPosition =       CGPoint(x:  200, y: -100)
    
}

struct SpeechElement {
    var audioName: String
    var position: CGPoint
    var imageName: String
    
    init(imageName: String,audioName: String, position: CGPoint) {
        self.imageName = imageName
        self.audioName = audioName
        self.position = position
    }
}

struct SpeechConstants {
    static let bubbles: [SpeechElement] = [
        .init(imageName: "speechBubbleAudio", audioName: "algumNomeAi", position: CGPoint(x: -400, y: 200)),
        .init(imageName: "speechBubbleAudio", audioName: "algumNomeAi", position: CGPoint(x: -400, y: 120)),
        .init(imageName: "speechBubbleAudio", audioName: "algumNomeAi", position: CGPoint(x: -400, y:  40)),
        .init(imageName: "speechBubbleAudio", audioName: "algumNomeAi", position: CGPoint(x: -400, y: -40))
    ]
    
    static let newLocation = CGPoint(x: -50, y: 50)
}

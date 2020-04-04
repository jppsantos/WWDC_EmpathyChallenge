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
    
    init(elementQuantity: Int, positions: [CGPoint], colors: [UIColor]) {
        self.elementQuantity = elementQuantity
        self.positions = positions
        self.colors = colors
    }
}

struct Levels {
    static let levels: [Level] = [
        Level(
            elementQuantity: 3,
            positions: [
                CGPoint(x: -150, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 150, y: 0)
            ],
            colors: [.red,.green,.blue]
        ),
        
        Level(
            elementQuantity: 4,
            positions: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0)
            ],
            colors: [.red,.green,.blue,.purple]
        ),
        
        Level(
            elementQuantity: 6,
            positions: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 0, y: 0)
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


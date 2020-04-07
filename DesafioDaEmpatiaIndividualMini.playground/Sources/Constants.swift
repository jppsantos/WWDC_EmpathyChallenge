//
//  Constants.swift
//  WWDCEmpatiaMiniJoaoXcode
//
//  Created by Joao Paulo Pereira dos Santos on 01/04/20.
//  Copyright © 2020 Joao Paulo Pereira dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

public struct Level {
    var elementQuantity: Int = 0
    var positions: [CGPoint] = []
    var colors: [UIColor] = []
    var sequence: [Int] = []
    var sounds: [String] = []
    
    public init(elementQuantity: Int, sequence: [Int], positions: [CGPoint], colors: [UIColor], sounds: [String]) {
        self.elementQuantity = elementQuantity
        self.positions = positions
        self.colors = colors
        self.sequence = sequence
        self.sounds = sounds
    }
}

public struct Levels {
    public static let levels: [Level] = [
        .init(
            elementQuantity: 3,
            sequence: [0,1,2,0],
            positions: [
                CGPoint(x: -150, y: 0),
                CGPoint(x: 0, y: 0),
                CGPoint(x: 150, y: 0)
            ],
            colors: [.red,.green,.blue],
            sounds: ["Cnote.mp3","Dnote.mp3","Enote.mp3"]
        ),
        
        .init(
            elementQuantity: 4,
            sequence: [0,1,3,1,2],
            positions: [
                CGPoint(x: -100, y:  100),
                CGPoint(x:  100, y:  100),
                CGPoint(x: -100, y: -100),
                CGPoint(x:  100, y: -100),
            ],
            colors: [.red,.green,.blue,.purple],
            sounds: ["Cnote.mp3","Dnote.mp3","Fnote.mp3","Gnote.mp3"]
        ),
        
        .init(
            elementQuantity: 6,
            sequence: [0,1,2,5,4,3,5],
            positions: [
                CGPoint(x: -150, y:   75),
                CGPoint(x:    0, y:  150),
                CGPoint(x:  150, y:   75),
                CGPoint(x:  150, y:  -75),
                CGPoint(x:    0, y: -150),
                CGPoint(x: -150, y:  -75),
            ],
            colors: [.red,.green,.blue,.purple,.cyan,.black],
            sounds: ["Cnote.mp3","Dnote.mp3","Enote.mp3",
                     "Fnote.mp3","Gnote.mp3","Anote.mp3"]
        )
    ]
    
}




public struct CardModel {
    var imageName: String = ""
    var position = CGPoint()
    
    public init(imageName: String, position: CGPoint) {
        self.imageName = imageName
        self.position = position
    }
}

public struct EmpathyConstants {
    public static let cards: [CardModel] = [
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

public struct SpeechElement {
    var id: Int
    var audioName: String
    var position: CGPoint
    var imageName: String
    
    public init(id:Int, imageName: String,audioName: String, position: CGPoint) {
        self.id = id
        self.imageName = imageName
        self.audioName = audioName
        self.position = position
    }
}

public struct SpeechConstants {
    public static let bubbles: [SpeechElement] = [
        .init(id: 0, imageName: "speechBubbleAudio", audioName: "wrongAudio0.m4a", position: CGPoint(x: -400, y: 150)),
        .init(id: 1, imageName: "speechBubbleAudio", audioName: "correctAudio0.m4a", position: CGPoint(x: -400, y:  50)),
        .init(id: 1, imageName: "speechBubbleAudio", audioName: "correctAudio0.m4a", position: CGPoint(x: -400, y: -50)),
        .init(id: 0, imageName: "speechBubbleAudio", audioName: "wrongAudio1.m4a", position: CGPoint(x: -400, y:-150))
    ]
    
    public static let newLocation = CGPoint(x: 70, y: -30)
}

public struct StartStateConstants {
    public static let initialMessage = "Desafio da Empatia"
    public static let messages: [String] = [
        "Bem vindo ao desafio da Empatia",
        "Você foi escolhido dentre muitas \npessoas para ajudar a Ana",
        "Ana está um pouco triste e voce deverá \nusar seu poder de empatia com ela",
        "Mas antes você precisa \ndesenvolver suas habilidades",
        "Vamos Começar!"
    ]
}

public struct SoundStateConstants {
    public static let initialMessage = "Desafio dos Sons"
    public static let messages: [String] = [
        "Ouvir é o primeiro grande desafio!",
        "Para que você seja empático desenvolva \n primeiro sua capacidade de ouvir",
        "Este é o primeiro passo!"
    ]
}


public struct EmpathyStateConstants {
    public static let initialMessage = "Desafio da Empatia"
    public static let messages: [String] = [
        "Agora você precisa olhar na \nperspectiva da outra pessoa",
        "Identifique na sua memória \nas mesmas memórias de Ana",
        "Tome para si as dores dela",
        "Este é o segundo passo!"
    ]
}

public struct SpeechStateConstants {
    public static let initialMessage = "Desafio da Fala"
    public static let messages: [String] = [
        "Hora da fala!",
        "Existem falas boas e \nruins nessa hora",
        "Descubra as boas falas",
        "Clique nos áudios!"
    ]
    
    public static let answerMessages: [String] = [
        "Essa nao é uma boa \nfala nessa momento!",
        "Essa é uma fala ideal!"
    ]
}

public struct MessageConstants {
    public var message: [String]
    
    public init(message: [String]) {
        self.message = message
    }
}

public struct InitialStateConstants {
    public static let messages: [MessageConstants] = [
        .init(message: [
            "Para ajudar Ana você precisa passar \npor um cada dos proximos desafios",
            "Clique em cada um dos \nbotões a seguir e descubra!",
            "Comece pelo que está liberado!"
        ]),
        .init(message: ["Parabéns! Vá para o próximo!"]),
        .init(message: ["Parabéns! Vá para o próximo!"]),
        .init(message: ["Desafios completos!"])
    ]
}

public struct FinalStateConstants {
    public static let defaultMessage = "Parabens, Desafio completo!"
    public static let messages: [String] = [
        "Você completou todos os desafios",
        "Agora você está pronto para ajudar Ana",
        "Mas desenvolva a empatia \ncom todos a sua volta!"
    ]
}

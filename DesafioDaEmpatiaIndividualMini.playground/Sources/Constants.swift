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
        .init(id: 1, imageName: "speechBubbleAudio", audioName: "correctAudio1.m4a", position: CGPoint(x: -400, y: -50)),
        .init(id: 0, imageName: "speechBubbleAudio", audioName: "wrongAudio1.m4a", position: CGPoint(x: -400, y:-150))
    ]
    
    public static let newLocation = CGPoint(x: 70, y: -30)
}

public struct StartStateConstants {
    public static let initialMessage = "Empathy Challenge"
    public static let messages: [String] = [
        "Welcome to the Empathy Challenge",
        "You were chosen from many \npeople to help Ana",
        "Ana is a little sad and you should \n use your empathic power with her",
        "But first you need \nto develop your skills",
        "Let's start!"
    ]
}

public struct SoundStateConstants {
    public static let initialMessage = "Sound Challenge"
    public static let messages: [String] = [
        "Listening is the first big challenge!",
        "In order for you to be empathetic develop \n first your ability to listen",
        "This is the first step!"
    ]
}


public struct EmpathyStateConstants {
    public static let initialMessage = "Empathy Challenge"
    public static let messages: [String] = [
        "Now you need to look at the \nother person's perspective",
        "Identify in your memory \nthe same memories as Ana",
        "Take her pains for yourself",
        "This is the second step!"
    ]
}

public struct SpeechStateConstants {
    public static let initialMessage = "Speech Challenge"
    public static let messages: [String] = [
        "Speech time!",
        "There are good and bad \nlines at this time",
        "Discover good speeches",
        "Click on the audios!"
    ]
    
    public static let answerMessages: [String] = [
        "This is not a good speech \nat the moment!",
        "This is an ideal speech!"
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
            "To help Ana you need to go through \neach of the next challenges",
            "Click on each of the \nbuttons below and find out!",
            "Start with what is released!"
        ]),
        .init(message: ["Congratulations! Go to the next one!"]),
        .init(message: ["Congratulations! Go to the next one!"]),
        .init(message: ["All challenges have been completed!"])
    ]
}

public struct FinalStateConstants {
    public static let defaultMessage = "Congratulations, Challenge finished!"
    public static let messages: [String] = [
        "You have completed all the challenges",
        "Now you're ready to help Ana",
        "But develop empathy \nwith everyone around you!"
    ]
}

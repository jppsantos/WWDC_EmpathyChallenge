import Foundation
import SpriteKit
import GameplayKit

public class GameScene: SKScene {
    public lazy var gameState = GKStateMachine(states: self.sceneStates)
    
    public lazy var sceneStates = [
        InitialState(self),
        SpeechChallengeState(self),
        EmpathyChallengeState(self),
        SoundChallengeState(self),
        FinalState(self)
    ]
    
    public lazy var controlNode: SKNode = {
        let node = SKNode()
        node.position = CGPoint.zero
        node.name = "controlNode"
        node.zPosition = 0
        return node
    }()
    
    public override func didMove(to view: SKView) {
        addChild(controlNode)
        gameState.enter(InitialState.self)
    }
    
    @objc public static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState.currentState.self is EmpathyChallengeState {
                  let state = gameState.currentState as! EmpathyChallengeState
                  guard let firstTouch = touches.first else { return }
                  let location = firstTouch.location(in: self)
                  state.touchesBegan(location: location)
              }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        let location = firstTouch.location(in: self)
        guard let node = self.nodes(at: location).first as? SKNode else {return}

        if node.name == "speechBubbleAudio" {
            node.position = location
        }
    }
   
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

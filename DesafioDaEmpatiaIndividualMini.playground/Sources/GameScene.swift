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
    
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  
    }
   
}


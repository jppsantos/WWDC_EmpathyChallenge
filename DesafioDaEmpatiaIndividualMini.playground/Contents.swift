/*:
 # *Empathy Challenge*
 
The Empathy Challenge  is a scene in which the user is led to develop three characteristics of empathy: listening, putting oneself in the other's shoes and speaking. Each of these features is represented by means of puzzles. In the end the user will be able to help the character Ana, who was a little sad but now knows that there is someone who understands her a little better.

 
 ## How to play
 - Click the navigation arrows until the next options are released 👆🏽.
 - Stay tuned for each of the challenges 👀.
 - Read the messages throughout the scene carefully 📖.
 
 ## **Good Luck and Have Fun!**
 */

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

//
//  ViewController.swift
//  Mr.Pig
//
//  Created by Hao Dong on 13/10/2016.
//  Copyright © 2016 Hao Dong. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ViewController: UIViewController {
    
    let game = GameHelper.sharedInstance
    var gameScene: SCNScene!
    var splashScene: SCNScene!
    var scnView: SCNView!
    var pigNode: SCNNode!
    var cameraNode: SCNNode!
    var cameraFollowNode: SCNNode!
    var lightFollowNode: SCNNode!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScenes()
        setupNodes()
        setupActions()
        setupTraffic()
        setupGestures()
        setupSounds()
        
        
    }

    func setupScenes() {
        scnView = SCNView(frame: self.view.frame)
        self.view.addSubview(scnView)
        
        gameScene = SCNScene(named: "/MrPig.scnassets/GameScene.scn")
        splashScene = SCNScene(named: "/MrPig.scnassets/SplashScene.scn")
        
        scnView.scene = splashScene
    }
    
    func setupNodes() {
        pigNode = gameScene.rootNode.childNode(withName: "MyPig", recursively: true)!
        cameraNode = gameScene.rootNode.childNode(withName: "camera", recursively: true)!
        cameraNode.addChildNode(game.hudNode)
        
        cameraFollowNode = gameScene.rootNode.childNode(withName: "FollowCamera", recursively: true)!
        
        lightFollowNode = gameScene.rootNode.childNode(withName: "FollowLight", recursively: true)!
        
    }
    
    func setupActions() {
        
    }
    
    func setupTraffic() {
        
    }
    
    func setupGestures() {
        
    }
    func setupSounds() {
        
    }
    func startGame() {
        splashScene.isPaused = true
        
        let transition = SKTransition.doorsOpenVertical(withDuration: 1.0)
        scnView.present(gameScene, with: transition, incomingPointOfView: nil, completionHandler: {
            self.game.state = .playing
            self.setupSounds()
            self.gameScene.isPaused = false
        })
    }
    func stopGame() {
        game.state = .gameOver
        game.reset()
    }
    func startSplash() {
        gameScene.isPaused = true
        
        let transition = SKTransition.doorsOpenVertical(withDuration: 1.0)
        scnView.present(splashScene, with: transition, incomingPointOfView: nil) { 
            self.game.state = .tapToPlay
            self.setupSounds()
            self.splashScene.isPaused = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if game.state == .tapToPlay {
            startGame()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override var prefersStatusBarHidden: Bool { return true }
    override var shouldAutorotate: Bool { return false }
    
}


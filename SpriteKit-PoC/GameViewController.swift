//
//  GameViewController.swift
//  SpriteKit-PoC
//
//  Created by Lucas on 2/21/17.
//  Copyright © 2017 Lucas Violini. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

  var shipScene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                shipScene = scene

            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }


  @IBAction func ZoomBtnAction(_ sender: Any) {
    shipScene.toggleZoom()
  }

  @IBAction func btnClearDayAction(_ sender: Any) {
    shipScene.clearDay()
  }


  @IBAction func btnRainyDayAction(_ sender: Any) {
    shipScene.rainyDay()
  }


  @IBAction func btnRainyNightAction(_ sender: Any) {
    shipScene.rainyNight()
  }

  @IBAction func btnClearNightAction(_ sender: Any) {
    shipScene.clearNight()
  }

  @IBAction func followPath(_ sender: Any) {
    shipScene.moveShipOnPath()
  }

}

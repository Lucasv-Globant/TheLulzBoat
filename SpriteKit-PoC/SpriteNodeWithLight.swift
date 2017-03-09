//
//  SpriteNodeWithLight.swift
//  SpriteKitPoC
//
//  Created by Lucas on 3/9/17.
//  Copyright © 2017 Lucas Violini. All rights reserved.
//

import UIKit
import SpriteKit

class SpriteNodeWithLight: SKSpriteNode {
  let lightSource = SKLightNode()
  func addLight() {
    if lightSource.parent == nil {
      lightSource.categoryBitMask = 1
      lightSource.falloff = 0.0001
      lightSource.ambientColor = UIColor.white //SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.85)
      lightSource.lightColor = SKColor(red: 0.8, green: 0.8, blue: 0.4, alpha: 0.1)
      lightSource.shadowColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)

      ///lightSource.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
      lightSource.setScale(0.01)
      lightSource.zPosition = 101
      addChild(lightSource)
    }

  }

  func removeLight() {
      lightSource.removeFromParent()
  }
}

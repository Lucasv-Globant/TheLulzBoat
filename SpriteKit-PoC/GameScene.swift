//
//  GameScene.swift
//  SpriteKit-PoC
//
//  Created by Lucas on 2/21/17.
//  Copyright © 2017 Lucas Violini. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    override func didMove(to view: SKView) {
      let ship = SKSpriteNode(imageNamed: "boat-lucas-small")
      ship.size = CGSize(width: 80, height: 266)
      ship.position = CGPoint(x:0/*self.frame.size.width / 2*/, y:0/*self.frame.size.height / 2*/)
      self.addChild(ship)
      var path = CGMutablePath()
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x:50,y:100))

      /*
      var followLine = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 3.0)
      var reversedLine = followLine.reversed()
      var square = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
      var followSquare = SKAction.follow(square.cgPath, asOffset: true, orientToPath: false, duration:5.0)
      */
      //var circle = UIBezierPath(roundedRect: CGRect(x:0,y:0,width:300,height:300), cornerRadius: 150)
      //var followCircle = SKAction.follow(circle.cgPath, asOffset: true, orientToPath: true, speed: 50.0)//SKAction.follow(circle.cgPath, asOffset: true, orientToPath: true, duration: 5.0)+
      //ship.run(SKAction.sequence([followCircle]))


      let shipPath = loadPathFor4InchesDisplays()
      let followShipPath = SKAction.follow(shipPath!, asOffset: true, orientToPath: true, speed: 20.0)

      ship.run(SKAction.sequence([followShipPath, followShipPath.reversed()]))

    }


    func loadPathFor4InchesDisplays() -> CGPath? {
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x: 57.5, y: 571.5))
      bezierPath.addCurve(to: CGPoint(x: 57.5, y: 505.5), controlPoint1: CGPoint(x: 62.28, y: 560.98), controlPoint2: CGPoint(x: 53.6, y: 546.04))
      bezierPath.addCurve(to: CGPoint(x: 152.5, y: 405.5), controlPoint1: CGPoint(x: 62.5, y: 453.5), controlPoint2: CGPoint(x: 125.5, y: 429.5))
      bezierPath.addCurve(to: CGPoint(x: 195.5, y: 323.5), controlPoint1: CGPoint(x: 209.69, y: 354.66), controlPoint2: CGPoint(x: 195.5, y: 323.5))
      bezierPath.addCurve(to: CGPoint(x: 267.5, y: 333.5), controlPoint1: CGPoint(x: 195.5, y: 323.5), controlPoint2: CGPoint(x: 246.5, y: 365.5))
      bezierPath.addCurve(to: CGPoint(x: 254.5, y: 273.5), controlPoint1: CGPoint(x: 288.5, y: 301.5), controlPoint2: CGPoint(x: 254.5, y: 273.5))
      bezierPath.addCurve(to: CGPoint(x: 163.5, y: 197.5), controlPoint1: CGPoint(x: 254.5, y: 273.5), controlPoint2: CGPoint(x: 182.5, y: 210.5))
      bezierPath.addCurve(to: CGPoint(x: 110.5, y: 211.5), controlPoint1: CGPoint(x: 144.5, y: 184.5), controlPoint2: CGPoint(x: 110.5, y: 211.5))
      bezierPath.addCurve(to: CGPoint(x: 146.5, y: 171.5), controlPoint1: CGPoint(x: 110.5, y: 211.5), controlPoint2: CGPoint(x: 117.5, y: 211.5))
      bezierPath.addCurve(to: CGPoint(x: 163.5, y: 67.5), controlPoint1: CGPoint(x: 175.5, y: 131.5), controlPoint2: CGPoint(x: 182.75, y: 100.5))
      bezierPath.addCurve(to: CGPoint(x: 69.5, y: 39.5), controlPoint1: CGPoint(x: 144.25, y: 34.5), controlPoint2: CGPoint(x: 69.5, y: 39.5))

      return bezierPath.cgPath
    }


    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

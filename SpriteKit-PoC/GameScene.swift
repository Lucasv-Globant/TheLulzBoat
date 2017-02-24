//
//  GameScene.swift
//  SpriteKit-PoC
//
//  Created by Lucas on 2/21/17.
//  Copyright © 2017 Lucas Violini. All rights reserved.
//

import SpriteKit
import GameplayKit

enum weatherCondition {
  case clearDay
  case rainyDay
  case clearNight
  case rainyNight
}

class GameScene: SKScene {

    var weather = weatherCondition.clearDay
    var isZoomedIn = false
    var oceanAtlas = SKTextureAtlas()
    var oceanTexturesArray = [SKTexture]()

  var rain : SKEmitterNode!
  var darkCloud: SKSpriteNode!
  override func didMove(to view: SKView) {

      ////////////////////////////////////////////////////////////////////
      // Water movement Option 1: using textures
      //
      oceanAtlas = SKTextureAtlas(named: "water")
      var oceanNode = SKSpriteNode()
      var names = [String]()
      for name in oceanAtlas.textureNames {
        names.append(name)
      }

      //Add the images in the progressive sequence
      names = names.sorted(by: {$0 < $1})
      for name in names {
        oceanTexturesArray.insert(SKTexture(imageNamed: name),at:0)
      }

      //Add the same sequence, but reversed (so that the animation will go back and forth):
      names = names.reversed()//names.sorted(by: {$0 > $1})
      for name in names {
        oceanTexturesArray.insert(SKTexture(imageNamed: name),at:0)
      }
      oceanNode.size = self.frame.size
      oceanNode.position = CGPoint(x: 0, y: 0)
      self.addChild(oceanNode)
      //let oceanLoopAction = SKAction.
      oceanNode.run(SKAction.repeatForever(SKAction.animate(with: oceanTexturesArray, timePerFrame: 0.2)))
      /////////////////////////////////////////////////////////////////
      // Water movement Option 2: Fragment shaders
      //
      //Setup a container sprite for the shader that makes the movement
      //let shaderContainerMove = SKSpriteNode(imageNamed: "dummypixel.png")
      //shaderContainerMove.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
      //shaderContainerMove.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      //self.addChild(shaderContainerMove)

      //Create the shader from a shader-file
      //let shaderMove : SKShader = SKShader(fileNamed: "shader_water_movement.fsh")

      //Set vairiables that are used in the shader script
      //shaderMove.uniforms = [ SKUniform(name: "size", float: GLKVector3(v: (Float(self.frame.size.width*1.5),Float(self.frame.size.height*1.5),0)))]

      //add the shader to the sprite
      //shaderContainerMove.shader = shaderMove

      ////////////////////////////////////////////////////////////////////
      //Setup a container sprite for the shader that makes the reflections
      //let shaderContainerReflect = SKSpriteNode(imageNamed: "dummypixel.png")
      //shaderContainerReflect.position = CGPoint(x: 0/*self.frame.size.width/2*/, y: 0/*self.frame.size.width/2*/)
      //shaderContainerReflect.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      //self.addChild(shaderContainerReflect)
      //Create the shader from a shader-file
      //let shaderReflect = SKShader(fileNamed: "shader_water_reflection.fsh")
      //Set variables that are used in the shader script
      //shaderReflect.uniforms = [SKUniform(name: "size", float: GLKVector3(v: (Float(self.frame.size.width),Float(self.frame.size.height),0)))]
      //add the shader to the sprite
      //shaderContainerReflect.shader = shaderReflect
      //shaderContainerReflect.zPosition = -1

      //////////////
      // The Boat
      let ship = SKSpriteNode(imageNamed: "boat-xxxhdpi")
      let shipHeight = self.frame.size.height / 2
      let shipWidth = shipHeight/3
      ship.size = CGSize(width: shipWidth, height: shipHeight)
      let shipPosX = -40
      let shipPosY = 0
      ship.position = CGPoint(x:shipPosX, y:shipPosY)
      ship.name = "ship"
      self.addChild(ship)
      ship.zPosition = 1


      ////////////////////////
      // Boat moving on path
      //var path = CGMutablePath()
      //path.move(to: CGPoint(x: 0, y: 0))
      //path.addLine(to: CGPoint(x:50,y:100))
      //let shipPath = loadPathFor4InchesDisplays()
      //let followShipPath = SKAction.follow(shipPath!, asOffset: true, orientToPath: true, speed: 20.0)
      //ship.run(SKAction.sequence([followShipPath, followShipPath.reversed()]))

      ///////////////////////////////
      // Camera position
      let cameraNode = SKCameraNode()
      cameraNode.position = CGPoint(x: 0/*(scene?.size.width)!/2*/, y: 0/*(scene?.size.height)!/2*/)
      scene?.addChild(cameraNode)
      scene?.camera = cameraNode

      ///////////////////////////////////////
      // Weather



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

  func toggleZoom() {
    let newScale = isZoomedIn ? 2 : 0.5
    isZoomedIn = !isZoomedIn
    let zoomInAction = SKAction.scale(by: CGFloat(newScale), duration: 1)
    scene?.camera?.run(zoomInAction)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    let touch = touches.first
    let location = touch?.location(in: self)
    let nodes = self.nodes(at: location!)
    for node in nodes {
      if node.name == "ship" {
        toggleZoom()
        break
      }
      else {
        print("yee")
      }
    }


  }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

  func rainyDay() {
    if weather != weatherCondition.rainyDay {
      if rain == nil {
      rain = SKEmitterNode(fileNamed: "RainParticle.sks")
      }
      rain?.position = CGPoint(x: 300, y: self.frame.size.height)
      rain?.zPosition = 10
      //rain?.particlePositionRange = CGVector(dx: 0, dy: 0)
      self.addChild(rain!)

      if darkCloud == nil {
        darkCloud = SKSpriteNode(imageNamed: "cloud")
        let cloudHeight = self.frame.size.height / 4
        let cloudWidth = cloudHeight*2
        darkCloud.size = CGSize(width: cloudWidth, height: cloudHeight)
        let cloudPosX = -40
        let cloudPosY = 400
        darkCloud.position = CGPoint(x:cloudPosX, y:cloudPosY)
        darkCloud.name = "cloud"
        self.addChild(darkCloud)
        darkCloud.zPosition = 11
      }
    }
    weather = weatherCondition.rainyDay
  }

  func clearDay() {
    if weather != weatherCondition.clearDay {
      rain?.removeFromParent()
      darkCloud?.removeFromParent()
    }
    weather = weatherCondition.clearDay
  }

  func clearNight() {
    if weather != weatherCondition.clearNight {
    }
    weather = weatherCondition.clearNight
  }

  func rainyNight() {
    if weather != weatherCondition.rainyNight {
    }
    weather = weatherCondition.rainyNight
  }
}

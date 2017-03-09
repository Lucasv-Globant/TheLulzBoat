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
    let lightSource = SKLightNode()

  var rain : SKEmitterNode!
  var darkCloud: SKSpriteNode!
  var darkCloud2: SKSpriteNode!
  var darkCloud3: SKSpriteNode!
  var dimPanel: SKSpriteNode!
  var oceanNode = SKSpriteNode()
  let ship = SpriteNodeWithLight()
  override func didMove(to view: SKView) {

      ////////////////////////////////////////////////////////////////////
      // Water movement Option 1: using textures
      //
      oceanAtlas = SKTextureAtlas(named: "water")

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
      oceanNode.size = CGSize(width: self.frame.size.width * 2, height: self.frame.size.height * 2)
      oceanNode.position = CGPoint(x: 0, y: 0)
      self.addChild(oceanNode)
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
      let shipHeight = self.frame.size.height / 2
      let shipWidth = shipHeight/3
      ship.size = CGSize(width: shipWidth, height: shipHeight)
      let shipPosX = -40
      let shipPosY = 0
      ship.position = CGPoint(x: 57.5, y: 571.5)//CGPoint(x:shipPosX, y:shipPosY)
      ship.name = "ship"
      self.addChild(ship)
      ship.zPosition = 1




      ///////////////////////////////
      // Camera position
      let cameraNode = SKCameraNode()
      cameraNode.position = CGPoint(x: 57.5, y: 571.5)//CGPoint(x: 0/*(scene?.size.width)!/2*/, y: 0/*(scene?.size.height)!/2*/)
      scene?.addChild(cameraNode)
      scene?.camera = cameraNode


      ///////////////////////////////////////
      // Playing around with Lights:
      oceanNode.lightingBitMask = 1
      oceanNode.shadowCastBitMask = 0
      oceanNode.shadowedBitMask = 1
      //addLight()

      ////////////////////////////////
      // configure boat
      let setBoatTexture = SKAction.setTexture(SKTexture(imageNamed: "boat-xxxhdpi"))
      ship.run(setBoatTexture)

    }


    func loadPathFor4InchesDisplays() -> CGPath? {
      let bezierPath = UIBezierPath()
      bezierPath.move(to: CGPoint(x:0, y: 0))//(x: 57.5, y: 571.5))
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


  func addRain() {
    if rain == nil {
      rain = SKEmitterNode(fileNamed: "RainParticle.sks")
    }
    rain?.position = CGPoint(x: 300, y: self.frame.size.height)
    rain?.zPosition = 10
    self.addChild(rain!)

    if darkCloud == nil {
      darkCloud = SKSpriteNode(imageNamed: "cloud")
      let cloudHeight = self.frame.size.height / 2
      let cloudWidth = cloudHeight*2
      darkCloud.size = CGSize(width: cloudWidth, height: cloudHeight)
      let cloudPosX = -40
      let cloudPosY = Int(self.frame.size.height/2)
      darkCloud.position = CGPoint(x:cloudPosX, y:cloudPosY)
      darkCloud.name = "cloud"
      darkCloud.zPosition = 11

      darkCloud2 = SKSpriteNode(imageNamed: "cloud")
      let cloud2Height = self.frame.size.height / 2
      let cloud2Width = cloud2Height*2
      darkCloud2.size = CGSize(width: cloud2Width, height: cloud2Height)
      let cloud2PosX = self.frame.size.width * 0.7
      let cloud2PosY = 120
      darkCloud2.position = CGPoint(x:Int(cloud2PosX), y:Int(cloud2PosY))
      darkCloud2.name = "cloud2"
      darkCloud2.zPosition = 11

      darkCloud3 = SKSpriteNode(imageNamed: "cloud")
      let cloud3Height = self.frame.size.height / 2
      let cloud3Width = cloud3Height*2
      darkCloud3.size = CGSize(width: cloud3Width, height: cloud3Height)
      let cloud3PosX = self.frame.size.width * -0.7
      let cloud3PosY = self.frame.size.height * -0.2
      darkCloud3.position = CGPoint(x:Int(cloud3PosX), y:Int(cloud3PosY))
      darkCloud3.name = "cloud3"
      darkCloud3.zPosition = 11

    }
    self.addChild(darkCloud)
    self.addChild(darkCloud2)
    self.addChild(darkCloud3)

  }

  func removeRain() {
    if (rain != nil) && (darkCloud != nil) {
      rain?.removeFromParent()
      darkCloud?.removeFromParent()
      darkCloud2?.removeFromParent()
      darkCloud3?.removeFromParent()
    }

  }

  func addNight() {
    //if dimPanel == nil {
    //  dimPanel = SKSpriteNode(color: UIColor.black, size: self.size)
    //  dimPanel.alpha = 0.55
    //  dimPanel.zPosition = 100
    //  dimPanel.position = CGPoint(x:0,y:0)//x: self.size.width/2, y: self.size.height/2)
    //}
    //self.addChild(dimPanel)
    oceanNode.colorBlendFactor = 0.25

  }

  func removeNight() {
    //if dimPanel != nil {
    //  dimPanel.removeFromParent()
    //}
    oceanNode.colorBlendFactor = 0
  }

  func rainyDay() {
    if weather != weatherCondition.rainyDay {
      addRain()
      removeNight()
    }
    weather = weatherCondition.rainyDay
  }

  func clearDay() {
    if weather != weatherCondition.clearDay {
      removeNight()
      removeRain()
    }
    weather = weatherCondition.clearDay
  }

  func clearNight() {
    if weather != weatherCondition.clearNight {
      addNight()
      removeRain()
    }
    weather = weatherCondition.clearNight
  }

  func rainyNight() {
    if weather != weatherCondition.rainyNight {
      addNight()
      addRain()
    }
    weather = weatherCondition.rainyNight
  }

  func addLight(){
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

  func moveShipOnPath() {
    ////////////////////////
    // Boat moving on path
    var path = CGMutablePath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x:50,y:100))
    let shipPath = loadPathFor4InchesDisplays()

    let followShipPath = SKAction.follow(shipPath!, asOffset: true, orientToPath: true, speed: 1000.0)
    ship.texture = SKTexture(imageNamed: "dot_white_500")
    let prevSize = ship.size
    let prevPos = ship.position

    let resizeToDotX = SKAction.scaleX(to: 0.2, duration: 0.2)
    let resizeToDotY = SKAction.scaleY(to: 0.1, duration: 0.2)

    let resizeToShipX = SKAction.scaleX(to: 1, duration: 0.2)
    let resizeToShipY = SKAction.scaleY(to: 1, duration: 0.2)

    ship.addLight()
    let setShipTexture = SKAction.setTexture(SKTexture(imageNamed: "boat-xxxhdpi"))
    //let resizeToShip = SKAction.resize(toWidth: prevSize.width, height: prevSize.height, duration: 0.3)
    ship.run(SKAction.sequence([resizeToDotX, resizeToDotY, followShipPath, followShipPath.reversed(), resizeToShipY, resizeToShipX, setShipTexture]))
    ship.position = prevPos
    
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    let location = touches.first?.location(in: self)
    lightSource.position = location!
  }
}

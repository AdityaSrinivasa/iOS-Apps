//
//  GameScene.swift
//  SuperSpaceMan
//
//  Created by IOSLevel-01 on 23/02/19.
//  Copyright © 2019 sjbit. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    let backgroundNode = SKSpriteNode(imageNamed: "space-backgroundPixabay")
    let foregroundNode = SKSpriteNode()
    let playerNode = SKSpriteNode(imageNamed: "Spaceship")
    let orbNode = SKSpriteNode(imageNamed: "orbImage")
   
   let CollisionCategoryPlayer  : UInt32 = 0x1 << 1
    let CollisionCategoryPowerUpOrbs : UInt32 = 0x1 << 2
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(size: CGSize) {
       
        
        super.init(size: size)
        
        

        physicsWorld.contactDelegate = self
       physicsWorld.gravity = CGVector(dx: 0.0, dy:  0.5);
        
        isUserInteractionEnabled = true
        
        //backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        backgroundNode.size.width = frame.size.width
backgroundNode.size.height = frame.size.height
backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
backgroundNode.position = CGPoint(x: size.width / 2.0, y: 0.0)
addChild(backgroundNode)
        addChild(foregroundNode)

        
       /* playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryPlayer
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryPowerUpOrbs
        playerNode.physicsBody?.collisionBitMask = 0*/
        
//playerNode.position = CGPoint(x: size.width / 1.0, y: 1.0)
        playerNode.physicsBody =  SKPhysicsBody(circleOfRadius: playerNode.size.width / 7)
        playerNode.physicsBody?.isDynamic = true
    
        playerNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playerNode.position = CGPoint(x: size.width / 2, y: 80.0)
        playerNode.size.width = frame.size.width/7
        playerNode.size.height = frame.size.height/7
        
        playerNode.physicsBody?.allowsRotation=false
        
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryPlayer
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryPowerUpOrbs
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.linearDamping = 1.0
        
        // default gravity setting in SpriteKit matches the earth’s gravitational forces, and the player node is now falling rapidly toward the center of the earth.
        //addChild(playerNode)
        foregroundNode.addChild(playerNode)

 //       CGVector(dx: 0.0, dy: -2.0)
        orbNode.name = "Planet"
        //orbNode.position = CGPoint(x: 150.0, y: size.height - 25)
        
        //orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
        var orbNodePosition = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 100)
        for _ in 0...19
        {
            let orbNode = SKSpriteNode(imageNamed: "orbImage")
            orbNodePosition.y += 140
            orbNode.position = orbNodePosition
            orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
            orbNode.physicsBody?.isDynamic = false
            orbNode.physicsBody?.categoryBitMask = CollisionCategoryPowerUpOrbs
            orbNode.physicsBody?.collisionBitMask = 0
            orbNode.name = "orbImage"
            foregroundNode.addChild(orbNode)
        }
        orbNodePosition = CGPoint(x: playerNode.position.x + 50, y: orbNodePosition.y)
        for _ in 0...19
        {
            let orbNode = SKSpriteNode(imageNamed: "orbImage")
            orbNodePosition.y += 140
            orbNode.position = orbNodePosition
              
            orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
              
            orbNode.physicsBody?.isDynamic = false
            orbNode.physicsBody?.categoryBitMask = CollisionCategoryPowerUpOrbs
            orbNode.physicsBody?.collisionBitMask = 0
            orbNode.name = "orbImage"
            foregroundNode.addChild(orbNode)
        }
        
      orbNode.physicsBody?.isDynamic = false
        orbNode.physicsBody?.categoryBitMask = CollisionCategoryPowerUpOrbs
        orbNode.physicsBody?.collisionBitMask = 0
       
        
                //addChild(orbNode)
        foregroundNode.addChild(orbNode)

       
        
    }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0,dy:  40.0))
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeB = contact.bodyB.node
        if nodeB?.name == "orbImage" {
            nodeB?.removeFromParent()
        }
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        if playerNode.position.y >= 180.0 {
            backgroundNode.position =
                CGPoint(x: backgroundNode.position.x,
                        y: -((playerNode.position.y - 180.0)/8))
            foregroundNode.position =
                CGPoint(x: foregroundNode.position.x,
                        y: -(playerNode.position.y - 180.0))
        } }
    
    
    }

extension GameScene: SKPhysicsContactDelegate {
    
    
}













/*claass GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}*/

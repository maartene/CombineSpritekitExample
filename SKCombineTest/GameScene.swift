//
//  GameScene.swift
//  SKCombineTest
//
//  Created by Maarten Engels on 04/04/2020.
//  Copyright © 2020 thedreamweb. All rights reserved.
//

import SpriteKit
import GameplayKit
import Combine

class GameScene: SKScene {
    
    var unitSpriteMap = [UUID: SKSpriteNode]()
    var world: World!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func didMove(to view: SKView) {
        world = World(numberOfUnits: 2500, width: Double(self.size.width), height: Double(self.size.height))
        
        world.$units.sink(receiveValue: { [weak self] units in
            guard let gc = self else {
                print("How is this being called if self is no longer available?")
                return
            }
            
            for unitID in units.keys {
                if let unit = units[unitID] {
                    if gc.unitSpriteMap[unitID] != nil {
                        gc.updateSpriteForUnit(unit)
                    } else {
                        gc.createSpriteForUnit(unit)
                    }
                }
            }
            }).store(in: &cancellables)
    }
    
    func createSpriteForUnit(_ unit: Unit) {
        let sprite = SKSpriteNode(imageNamed: "Reindeer")
        sprite.position = CGPoint(x: unit.posX, y: unit.posY)
        unitSpriteMap[unit.id] = sprite
        self.addChild(sprite)
    }
    
    func updateSpriteForUnit(_ unit: Unit) {
        if let sprite = unitSpriteMap[unit.id] {
            sprite.position = CGPoint(x: unit.posX, y: unit.posY)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        world.step()
    }
}



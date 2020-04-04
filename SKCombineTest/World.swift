//
//  World.swift
//  SKCombineTest
//
//  Created by Maarten Engels on 04/04/2020.
//  Copyright © 2020 thedreamweb. All rights reserved.
//

import Foundation
import Combine


class World: ObservableObject {
    @Published var units: [UUID: Unit]
    
    let width: Double
    let height: Double
    
    func step() {
        if let randomUnitID = units.keys.randomElement() {
            units[randomUnitID] = units[randomUnitID]!.update()
        }
    }
    
    init(numberOfUnits: Int, width: Double, height: Double) {
        units = [UUID: Unit]()
        self.width = width
        self.height = height
        
        for _ in 0 ..< numberOfUnits {
            let newUnit = Unit(movementRangeX: 0...width, movementRangeY: 0...height)
            units[newUnit.id] = newUnit
        }
    }
}

struct Unit {
    let id: UUID
    var posX: Double
    var posY: Double
    
    var movementRangeX: ClosedRange<Double>
    var movementRangeY: ClosedRange<Double>
    
    init(movementRangeX: ClosedRange<Double>, movementRangeY: ClosedRange<Double>) {
        id = UUID()
        self.movementRangeX = movementRangeX
        self.movementRangeY = movementRangeY
        posX = Double.random(in: movementRangeX)
        posY = Double.random(in: movementRangeY)
    }
    
    func update() -> Unit {
        var changedUnit = self
        changedUnit.posX = Double.random(in: movementRangeX)
        changedUnit.posY = Double.random(in: movementRangeY)
        
        return changedUnit
    }
}

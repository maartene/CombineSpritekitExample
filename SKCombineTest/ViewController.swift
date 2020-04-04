//
//  ViewController.swift
//  SKCombineTest
//
//  Created by Maarten Engels on 04/04/2020.
//  Copyright © 2020 thedreamweb. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: CGSize(width: skView.bounds.width, height: skView.bounds.height))
        scene.scaleMode = .aspectFill
        
        // Present the scene
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
}


//
//  GameScene.swift
//  GraphGames
//
//  Created by Leandro Sousa on 14/03/16.
//  Copyright (c) 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	
	var gameNumber: Int = 0
	var level: Int = 0
	
	init(gameNumber: Int, level: Int) {
		self.gameNumber = gameNumber
		self.level = level
		super.init(size: screenSize)
	}
	
	override init() {
		super.init(size: screenSize)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

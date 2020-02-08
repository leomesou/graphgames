//
//  GenericLevel.swift
//  GraphGames
//
//  Created by Leandro Sousa on 06/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GenericLevel: SKSpriteNode {
	
	let textureButton = SKTexture(imageNamed: "levelEmpty")
	let title = SKLabelNode(fontNamed: font)
	var levelState: LevelState
	let levelNumber: Int
	
	init(levelNumber: Int) {
		
		let size = textureButton.size()
		
		title.fontSize = 75
		title.fontColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
		title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
		title.text = String(levelNumber)
		title.zPosition = 101
		
		levelState = LevelState.empty
		
		self.levelNumber = levelNumber
		
		super.init(texture: textureButton, color: UIColor.gray, size: size)
		zPosition = 98
		
		//texture = SKTexture(imageNamed: "")
		
		title.position = CGPoint(x: self.position.x, y: self.position.y - 27)
		addChild(title)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

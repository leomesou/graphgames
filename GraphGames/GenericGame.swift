//
//  GenericGame.swift
//  GraphGames
//
//  Created by Leandro Sousa on 31/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GenericGame: SKSpriteNode {

	let textureButton = SKTexture(imageNamed: "tile")
	let title = SKLabelNode(fontNamed: font)
	let gameNumber: Int

	init(titleName: String, gameNumber: Int) {

		self.gameNumber = gameNumber

		let size = textureButton.size()

		title.fontSize = 100
		title.fontColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
		title.text = titleName
		title.zPosition = 101

		super.init(texture: textureButton, color: UIColor.gray, size: size)
		zPosition = 100

		title.position = CGPoint(x: self.position.x, y: self.position.y - 30)
		addChild(title)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

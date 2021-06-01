//
//  HomeButton.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class HomeButton: SKSpriteNode {

	init() {

		let texture = SKTexture(imageNamed: "tile")
		let size = CGSize(width: 900, height: 125)

		let title = SKLabelNode(fontNamed: font)
		title.fontSize = 100
		title.fontColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
		title.text = "HOME"
		title.zPosition = 101

		super.init(texture: texture, color: UIColor.gray, size: size)
		zPosition = 100

		title.position = CGPoint(x: self.position.x, y: self.position.y - 30)
		addChild(title)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func goToHomeScreen() {
		if let sceneView = parent?.scene?.view {
			let mainMenu = MainMenu()
			mainMenu.scaleMode = .aspectFill
			sceneView.presentScene(mainMenu)
		}
	}
}

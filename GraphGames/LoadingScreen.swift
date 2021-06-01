//
//  LoadingScreen.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class LoadingScreen: SKScene {

	override init() {
		super.init(size: screenSize)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func didMove(to view: SKView) {
		//createBackground()
		presentMenu()
	}

//	func createBackground() {
//		let background = SKSpriteNode(imageNamed: "background")
//		background.size = screenSize)
//		background.position = CGPoint(x: size.width/2, y: size.height/2)
//		background.zPosition = -1
//		addChild(background)
//	}

	func presentMenu() {
		let mainMenu = MainMenu()
		mainMenu.scaleMode = .aspectFill
		view?.presentScene(mainMenu)
	}
}

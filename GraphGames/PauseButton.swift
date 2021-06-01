//
//  PauseButton.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class PauseButton: SKSpriteNode {

	init() {
		let texture = SKTexture(imageNamed: "tile")
		let size = CGSize(width: 120, height: 120)

		super.init(texture: texture, color: UIColor.gray, size: size)
		zPosition = 97

		isUserInteractionEnabled = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		colorBlendFactor = 0.3
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		colorBlendFactor = 0.3
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		colorBlendFactor = 0.0
		//pauseGame()
		//let scene = parent?.scene as! GameScene
		//scene.hudManager.pauseScreen.show()
	}

//	func pauseGame() {
//		let gameScene = parent?.scene as! GameScene
//		gameScene.isGamePaused = true
//		soundManager.pauseBackgroundSound()
//	}

//	func continueGame() {
//		let gameScene = parent?.scene as! GameScene
//		gameScene.isGamePaused = false
//		soundManager.playBackgroundSound()
//	}
}

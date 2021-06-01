//
//  PostGameScreen.swift
//  GraphGames
//
//  Created by Leandro Sousa on 04/07/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class PostGameScreen: SKNode {

	let screenMenu   = SKSpriteNode(imageNamed: "screenSettings")
	let btnMainMenu  = GenericButton(titleName: "MAIN MENU")
	let btnLevelMenu = GenericButton(titleName: "LEVEL MENU")
	let btnNextLevel = GenericButton(titleName: "NEXT LEVEL")

	override init() {

		super.init()

		let blackView       = SKShapeNode(rectOf: screenSize)
		let screenTitle     = SKSpriteNode(imageNamed: "tile")
		let screenTitleText = SKLabelNode(fontNamed: font)

		blackView.fillColor = UIColor.black.withAlphaComponent(0.5)
		blackView.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		blackView.zPosition = 101

		screenMenu.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		screenMenu.zPosition = 102

		screenTitle.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 410)
		screenTitle.zPosition = 103

		screenTitleText.text      = "LEVEL COMPLETE"
		screenTitleText.fontSize  = 75
		screenTitleText.fontColor = UIColor.white
		screenTitleText.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 380)
		screenTitleText.zPosition = 105

		btnMainMenu.position         = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 100)
		btnMainMenu.zPosition        = 103
		btnMainMenu.title.zPosition  = 105
		btnLevelMenu.position        = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 50)
		btnLevelMenu.zPosition       = 103
		btnLevelMenu.title.zPosition = 105
		btnNextLevel.position        = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 250)
		btnNextLevel.zPosition       = 103
		btnNextLevel.title.zPosition = 105

		isHidden = true

		addChild(blackView)
		addChild(screenMenu)
		addChild(screenTitle)
		addChild(screenTitleText)

		addChild(btnMainMenu)
		addChild(btnLevelMenu)
		addChild(btnNextLevel)

		showButtonNextLevel()

		isUserInteractionEnabled = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func showButtonNextLevel() {
		if let gameScene = parent?.scene as? GameScene {
			if gameScene.level >= numberOfLevels {
				btnNextLevel.isHidden = true
			}
		}
	}

	func show() {
		isHidden = false
	}

	func dismiss() {
		isHidden = true
	}

	func actionMainMenu() {
		if let sceneView = parent?.scene?.view {
			let mainMenu = MainMenu()
			mainMenu.scaleMode = .aspectFill
			sceneView.presentScene(mainMenu)
		}
	}

	func actionLevelMenu() {
		if let sceneView = parent?.scene?.view,
		   let gameScene = parent?.scene as? GameScene {
			let levelSelectionMenu = LevelSelectionMenu(gameNumber: gameScene.gameNumber)
			levelSelectionMenu.scaleMode = .aspectFill
			sceneView.presentScene(levelSelectionMenu)
		}
	}

	func actionNextLevel() {
		if let sceneView = parent?.scene?.view,
		   let gameScene = parent?.scene as? GameScene {
			var newGameScene = GameScene()
			if gameScene is GameSceneKRegular {
				newGameScene = GameSceneKRegular(level: gameScene.level+1)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
			else if gameScene is GameScenePlanar {
				newGameScene = GameScenePlanar(level: gameScene.level+1)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnMainMenu.contains(location) && !isHidden {
				btnMainMenu.colorBlendFactor = 0.3
			}
			else if btnLevelMenu.contains(location) && !isHidden {
				btnLevelMenu.colorBlendFactor = 0.3
			}
			else if btnNextLevel.contains(location) && !isHidden {
				btnNextLevel.colorBlendFactor = 0.3
			}
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnMainMenu.contains(location) && !isHidden {
				btnMainMenu.colorBlendFactor  = 0.3
			} else {
				btnMainMenu.colorBlendFactor  = 0.0
			}
			if btnLevelMenu.contains(location) && !isHidden {
				btnLevelMenu.colorBlendFactor = 0.3
			} else {
				btnLevelMenu.colorBlendFactor = 0.0
			}
			if btnNextLevel.contains(location) && !isHidden {
				btnNextLevel.colorBlendFactor = 0.3
			} else {
				btnNextLevel.colorBlendFactor = 0.0
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			btnMainMenu.colorBlendFactor  = 0.0
			btnLevelMenu.colorBlendFactor = 0.0
			btnNextLevel.colorBlendFactor = 0.0

			if btnMainMenu.contains(location) && !isHidden {
				actionMainMenu()
			}
			else if btnLevelMenu.contains(location) && !isHidden {
				actionLevelMenu()
			}
			else if btnNextLevel.contains(location) && !isHidden {
				actionNextLevel()
			}
			else if !screenMenu.contains(location) && !isHidden {
				dismiss()
			}
		}
	}
}

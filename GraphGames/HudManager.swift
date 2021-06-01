//
//  HudManager.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class HudManager: SKNode {

	let btnBack    = SKSpriteNode(imageNamed: "buttonArrow")
	let btnPrevLvl = SKSpriteNode(imageNamed: "buttonArrow")
	let btnNextLvl = SKSpriteNode(imageNamed: "buttonArrow")
	let btnRestart = SKSpriteNode(imageNamed: "buttonRestart")
	let btnOptions = SKSpriteNode(imageNamed: "buttonSettings")
	let btnState   = SKSpriteNode()

	let optionsInGameScreen = OptionsInGameScreen()
	let postGameScreen = PostGameScreen()

	override init() {

		super.init()

		addChild(optionsInGameScreen)
		addChild(postGameScreen)

		createButtonState()
		createButtonBack()
		createButtonOptions()
		createButtonRestart()

		isUserInteractionEnabled = true

		zPosition = 96
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func createButtonBack() {
		btnBack.size = CGSize(width: 110, height: 110)
		btnBack.position = CGPoint(x: 292, y: screenSize.height - 150)
		btnBack.zPosition = 98
		addChild(btnBack)
	}

	func createButtonState() {
		btnState.color = UIColor.red
		btnState.size = CGSize(width: 250, height: 125)
		btnState.position = CGPoint(x: 292 + 50, y: 125)
		btnState.zPosition = 98
		addChild(btnState)
	}

	func createButtonOptions() {
		btnOptions.size = CGSize(width: 100, height: 100)
		btnOptions.position = CGPoint(x: screenSize.width - 292, y: screenSize.height - 150)
		btnOptions.zPosition = 98
		addChild(btnOptions)
	}

	func createButtonRestart() {
		btnRestart.size = CGSize(width: 80, height: 80)
		btnRestart.position = CGPoint(x: screenSize.width/2, y: screenSize.height - 200)
		btnRestart.zPosition = 98
		addChild(btnRestart)
	}

	func createLevelButtons() {

		createButtonPreviousLevel()
		createButtonNextLevel()

		if let gameScene = parent?.scene as? GameScene {
			if gameScene.level <= 1 {
				//Sombrear botão level anterior
				btnPrevLvl.colorBlendFactor = 0.5
			}
			if gameScene.level >= numberOfLevels {
				//Sombrear botão level posterior
				btnNextLvl.colorBlendFactor = 0.5
			}
			//se level posterior estiver bloqueado, não mostrar
			let gameLevels = plistManager.gameDataDict.value(forKey: "game\(gameScene.gameNumber)") as! NSMutableArray
			let nextLevelState = gameLevels.object(at: gameScene.level) as! Int
			if nextLevelState == 2 { //LevelState.Locked
				btnNextLvl.colorBlendFactor = 0.5
			}
		}
	}

	func createButtonPreviousLevel() {
		btnPrevLvl.size = CGSize(width: 80, height: 80)
		btnPrevLvl.position = CGPoint(x: screenSize.width/2 - 125, y: screenSize.height - 200)
		btnPrevLvl.zPosition = 98
		btnPrevLvl.color = UIColor.gray
		btnPrevLvl.colorBlendFactor = 0.0
		addChild(btnPrevLvl)
	}

	func createButtonNextLevel() {
		btnNextLvl.xScale = -1
		btnNextLvl.size = CGSize(width: 80, height: 80)
		btnNextLvl.position = CGPoint(x: screenSize.width/2 + 125, y: screenSize.height - 200)
		btnNextLvl.zPosition = 98
		btnNextLvl.color = UIColor.gray
		btnNextLvl.colorBlendFactor = 0.0
		addChild(btnNextLvl)
	}

	func createLabelDegree() {
		if let gameScene = parent?.scene as? GameSceneKRegular {
			let lblDegree  = SKLabelNode(fontNamed: font)
			lblDegree.text = String(gameScene.degree)
			lblDegree.fontSize = 120
			lblDegree.position = CGPoint(x: screenSize.width/2, y: 90)
			lblDegree.zPosition = 98
			lblDegree.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
			addChild(lblDegree)

			let lblDegreeText = SKLabelNode(fontNamed: font)
			lblDegreeText.text = "DEGREE"
			lblDegreeText.fontSize = 35
			lblDegreeText.position = CGPoint(x: screenSize.width/2, y: 195)
			lblDegreeText.zPosition = 98
			lblDegreeText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
			addChild(lblDegreeText)
		}
	}

	func actionState() {
		if let gameScene = parent?.scene as? GameSceneKRegular {
			if gameScene.moveVertex {
				gameScene.moveVertex = false
				btnState.color = UIColor.red
			}
			else {
				gameScene.moveVertex = true
				btnState.color = UIColor.blue
			}
		}
	}

	func actionBack() {
		if let sceneView = parent?.scene?.view,
		   let gameScene = parent?.scene as? GameScene {
			let levelSelectionMenu = LevelSelectionMenu(gameNumber: gameScene.gameNumber)
			levelSelectionMenu.scaleMode = .aspectFill
			sceneView.presentScene(levelSelectionMenu)
		}
	}

	func actionOptions() {
		optionsInGameScreen.show()
	}

	func actionRestart() {
		if let sceneView = parent?.scene?.view,
		   let gameScene = parent?.scene as? GameScene {
			var newGameScene = GameScene()
			if gameScene is GameSceneKRegular {
				newGameScene = GameSceneKRegular(level: gameScene.level)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
			else if gameScene is GameScenePlanar {
				newGameScene = GameScenePlanar(level: gameScene.level)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
		}
	}

	func actionPreviousLevel() {
		if let sceneView = parent?.scene?.view,
		   let gameScene = parent?.scene as? GameScene {
			var newGameScene = GameScene()
			if gameScene is GameSceneKRegular {
				newGameScene = GameSceneKRegular(level: gameScene.level-1)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
			else if gameScene is GameScenePlanar {
				newGameScene = GameScenePlanar(level: gameScene.level-1)
				newGameScene.scaleMode = .aspectFill
				sceneView.presentScene(newGameScene)
			}
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
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			if btnBack.contains(location) {
				btnBack.colorBlendFactor = 0.3
			}
			else if btnOptions.contains(location) {
				btnOptions.colorBlendFactor = 0.3
			}
			else if btnRestart.contains(location) {
				btnRestart.colorBlendFactor = 0.3
			}
			else if btnPrevLvl.contains(location) {
				if btnPrevLvl.colorBlendFactor != 0.5 {
					btnPrevLvl.colorBlendFactor = 0.3
				}
			}
			else if btnNextLvl.contains(location) {
				if btnNextLvl.colorBlendFactor != 0.5 {
					btnNextLvl.colorBlendFactor = 0.3
				}
			}
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			if btnBack.contains(location) {
				btnBack.colorBlendFactor = 0.3
			} else {
				btnBack.colorBlendFactor = 0.0
			}
			if btnOptions.contains(location) {
				btnOptions.colorBlendFactor = 0.3
			} else {
				btnOptions.colorBlendFactor = 0.0
			}
			if btnRestart.contains(location) {
				btnRestart.colorBlendFactor = 0.3
			} else {
				btnRestart.colorBlendFactor = 0.0
			}
			if btnPrevLvl.contains(location) {
				if btnPrevLvl.colorBlendFactor != 0.5 {
					btnPrevLvl.colorBlendFactor = 0.3
				}
			} else {
				if btnPrevLvl.colorBlendFactor != 0.5 {
					btnPrevLvl.colorBlendFactor = 0.0
				}
			}
			if btnNextLvl.contains(location) {
				if btnNextLvl.colorBlendFactor != 0.5 {
					btnNextLvl.colorBlendFactor = 0.3
				}
			} else {
				if btnNextLvl.colorBlendFactor != 0.5 {
					btnNextLvl.colorBlendFactor = 0.0
				}
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			btnBack.colorBlendFactor = 0.0
			if btnBack.contains(location) {
				actionBack()
			}
			btnOptions.colorBlendFactor = 0.0
			if btnOptions.contains(location) {
				actionOptions()
			}
			btnRestart.colorBlendFactor = 0.0
			if btnRestart.contains(location) {
				actionRestart()
			}
			if btnPrevLvl.colorBlendFactor != 0.5 {
				btnPrevLvl.colorBlendFactor = 0.0
			}
			if btnPrevLvl.contains(location) {
				if btnPrevLvl.colorBlendFactor != 0.5 {
					actionPreviousLevel()
				}
			}
			if btnNextLvl.colorBlendFactor != 0.5 {
				btnNextLvl.colorBlendFactor = 0.0
			}
			if btnNextLvl.contains(location) {
				if btnNextLvl.colorBlendFactor != 0.5 {
					actionNextLevel()
				}
			}
			if btnState.contains(location) {
				actionState()
			}
		}
	}
}

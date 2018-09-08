//
//  LevelSelectionMenu.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class LevelSelectionMenu: SKScene {
	
	let gameNumber: Int
	
	let background  = SKSpriteNode(imageNamed: "background")
	let levelsTitle = SKSpriteNode(imageNamed: "titleLevels")
	let btnBack     = SKSpriteNode(imageNamed: "buttonArrow")
	
	var levels: NSMutableArray
	
	init(gameNumber: Int) {
		self.gameNumber = gameNumber
		let levelsArray: [GenericLevel] = []
		levels = NSMutableArray(object: levelsArray)
		super.init(size: screenSize)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMove(to view: SKView) {
		createBackground()
		createLevelsTitle()
		createButtonBack()
		createLevels()
		updateView()
	}
	
	func createBackground() {
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -1
		addChild(background)
	}
	
	func createLevelsTitle() {
		levelsTitle.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
		levelsTitle.zPosition = 4
		addChild(levelsTitle)
	}
	
	func createButtonBack() {
		btnBack.size = CGSize(width: 100, height: 100)
		btnBack.position = CGPoint(x: frame.minX + 292, y: frame.maxY - 100)
		btnBack.zPosition = 98
		addChild(btnBack)
	}
	
	func createLevels() {
		
		for i in 1...numberOfLevels {
			levels.add(GenericLevel(levelNumber: i))
		}
		
		var positionX: CGFloat = -360.0
		var positionY: CGFloat =  540.0
		for level in levels {
			if let level = level as? GenericLevel {
				if ((level.levelNumber - 1) % 5 == 0) {
					positionX = -360.0
					positionY -= 180.0
				}
				level.size = CGSize(width: 140, height: 140)
				level.position = CGPoint(x: frame.midX + positionX, y: frame.midY + positionY)
				level.zPosition = 98
				addChild(level)
				positionX += 180
			}
		}
	}
	
	func updateView() {
		
//		plistManager.saveGame(gameNumber, levelNumber:  0, levelState: LevelState.Complete)
//		plistManager.saveGame(gameNumber, levelNumber:  7, levelState: LevelState.Locked)
//		plistManager.saveGame(gameNumber, levelNumber:  5, levelState: LevelState.Complete)
//		plistManager.saveGame(gameNumber, levelNumber: 13, levelState: LevelState.Locked)
//		plistManager.saveGame(gameNumber, levelNumber: 24, levelState: LevelState.Complete)
//		plistManager.saveGame(gameNumber, levelNumber: 17, levelState: LevelState.Locked)
		
		let gameLevels = plistManager.gameDataDict.value(forKey: "game\(gameNumber)") as! NSMutableArray
		
		for level in 0...numberOfLevels-1 {
			let levelState = gameLevels.object(at: level) as! Int
			let levelNode = levels.object(at: level+1) as! GenericLevel
//			print("\(levelNode.description)")
			switch levelState {
			case 0:
				levelNode.levelState = LevelState.empty
				levelNode.texture = SKTexture(imageNamed: "levelEmpty")
				levelNode.colorBlendFactor = 0.0
//				print("Level \(level+1) vazio")
			case 1:
				levelNode.levelState = LevelState.complete
				levelNode.texture = SKTexture(imageNamed: "levelComplete")
				levelNode.colorBlendFactor = 0.0
//				print("Level \(level+1) completo")
			case 2:
				levelNode.levelState = LevelState.locked
				levelNode.texture = SKTexture(imageNamed: "levelLocked")
				levelNode.colorBlendFactor = 0.5
//				print("Level \(level+1) fechado")
			default:
//				print("Level error")
				break
			}
		}
	}
	
	func actionLevel(_ levelNumber: Int) {
		
		let gameScene: SKScene
		
		switch gameNumber {
		case 1:
			gameScene = GameScenePlanar(level: levelNumber)
		case 2:
			gameScene = GameSceneKRegular(level: levelNumber)
		case 3:
			gameScene = GameScene(gameNumber: gameNumber, level: levelNumber)
		default:
			gameScene = GameScene(gameNumber: gameNumber, level: levelNumber)
		}
		
		gameScene.scaleMode = .aspectFill
		view?.presentScene(gameScene)
	}
	
	func actionBack() {
		let gameSelectionMenu = GameSelectionMenu()
		gameSelectionMenu.scaleMode = .aspectFill
		view?.presentScene(gameSelectionMenu)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)
			
			for level in levels {
				if let level = level as? GenericLevel {
					if level.contains(location) {
						if level.colorBlendFactor != 0.5 {
							level.colorBlendFactor = 0.3
						}
					}
				}
			}
			if btnBack.contains(location) {
				btnBack.colorBlendFactor = 0.3
			}
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)
			
			for level in levels {
				if let level = level as? GenericLevel {
					if level.contains(location) {
						if level.colorBlendFactor != 0.5 {
							level.colorBlendFactor = 0.3
						}
					}
					else {
						if level.colorBlendFactor != 0.5 {
							level.colorBlendFactor = 0.0
						}
					}
				}
			}
			if btnBack.contains(location) {
				btnBack.colorBlendFactor = 0.3
			} else {
				btnBack.colorBlendFactor = 0.0
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)
			
			for level in levels {
				if let level = level as? GenericLevel {
					if level.colorBlendFactor != 0.5 {
						level.colorBlendFactor = 0.0
					}
					if level.contains(location) {
						if level.colorBlendFactor != 0.5 {
							actionLevel(level.levelNumber)
						}
					}
				}
			}
			btnBack.colorBlendFactor = 0.0
			if btnBack.contains(location) {
				actionBack()
			}
		}
	}
}

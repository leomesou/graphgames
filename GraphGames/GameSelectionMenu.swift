//
//  GameSelectionMenu.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GameSelectionMenu: SKScene {

	let background = SKSpriteNode(imageNamed: "background")
	let gamesTitle = SKSpriteNode(imageNamed: "titleGames")
	let btnBack    = SKSpriteNode(imageNamed: "buttonArrow")

	var games: [GenericGame] = []

	override init() {
		super.init(size: screenSize)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func didMove(to view: SKView) {
		createBackground()
		createGamesTitle()
		createButtonBack()
		createGames()
	}

	func createBackground() {
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -1
		addChild(background)
	}

	func createGamesTitle() {
		gamesTitle.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
		gamesTitle.zPosition = 4
		addChild(gamesTitle)
	}

	func createButtonBack() {
		btnBack.size = CGSize(width: 100, height: 100)
		btnBack.position = CGPoint(x: frame.minX + 292, y: frame.maxY - 100)
		btnBack.zPosition = 98
		addChild(btnBack)
	}

	func createGames() {

		games.append(GenericGame(titleName: "Planificar",			 gameNumber: 1))
		games.append(GenericGame(titleName: "Grau",					 gameNumber: 2))
		games.append(GenericGame(titleName: "Cobertura de vértices", gameNumber: 3))
		games.append(GenericGame(titleName: "Cobertura de arestas",	 gameNumber: 4))

		var position: CGFloat = 10.0
		for game in games {
			game.size = CGSize(width: 700, height: 140)
			game.position = CGPoint(x: frame.midX, y: frame.midY - position)
			game.title.fontSize = 75
			game.title.position.y += 3
			game.title.zPosition = 2
			game.zPosition = 98
			addChild(game)
			position += 200
		}
	}

	func actionGame(_ gameNumber: Int) {
		let levelSelectionMenu = LevelSelectionMenu(gameNumber: gameNumber)
		levelSelectionMenu.scaleMode = .aspectFill
		view?.presentScene(levelSelectionMenu)
	}

	func actionBack() {
		let mainMenu = MainMenu()
		mainMenu.scaleMode = .aspectFill
		view?.presentScene(mainMenu)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			for game in games {
				if game.contains(location) {
					game.colorBlendFactor = 0.3
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

			for game in games {
				if game.contains(location) {
					game.colorBlendFactor = 0.3
				} else {
					game.colorBlendFactor = 0.0
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

			btnBack.colorBlendFactor = 0.0
			for game in games {
				game.colorBlendFactor = 0.0
				if game.contains(location) {
					actionGame(game.gameNumber)
				}
			}
			if btnBack.contains(location) {
				actionBack()
			}
		}
	}
}

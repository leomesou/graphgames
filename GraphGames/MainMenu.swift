//
//  MainMenu.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {

	let background = SKSpriteNode(imageNamed: "background")
	let logo       = SKSpriteNode(imageNamed: "logo")

	let btnPlay       = GenericButton(titleName: "PLAY")
	let btnGameCenter = GenericButton(titleName: "GAME CENTER")
	let btnOptions    = GenericButton(titleName: "OPTIONS")

	let optionsScreen = OptionsScreen()

	override init() {
		super.init(size: screenSize)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func didMove(to view: SKView) {
		//createSound()
		createBackground()
		createLogo()
		createButtonPlay()
		createButtonGameCenter()
		createButtonOptions()
		animateLogo()
	}

	func createSound() {
		//soundManager.playBackgroundSound(Sound.mainMenu)
	}

	func createBackground() {
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -1
		addChild(background)
	}

	func createLogo() {
		logo.setScale(0.95)
		logo.position = CGPoint(x: frame.midX, y: frame.maxY - 300)
		logo.zPosition = 4
		addChild(logo)
	}

	func createButtonPlay() {
		btnPlay.size = CGSize(width: 750, height: 180)
		btnPlay.position = CGPoint(x: frame.midX, y: frame.midY + 00.0)
		btnPlay.title.fontSize = 130
		btnPlay.title.position.y -= 15
		btnPlay.title.zPosition = 2
		btnPlay.zPosition = 98
		addChild(btnPlay)
	}

	func createButtonGameCenter() {
		btnGameCenter.size = CGSize(width: 700, height: 140)
		btnGameCenter.position = CGPoint(x: frame.midX, y: frame.midY - 310.0)
		btnGameCenter.title.fontSize = 75
		btnGameCenter.title.position.y += 3
		btnGameCenter.title.zPosition = 2
		btnGameCenter.zPosition = 98
		addChild(btnGameCenter)
	}

	func createButtonOptions() {
		btnOptions.size = CGSize(width: 700, height: 140)
		btnOptions.position = CGPoint(x: frame.midX, y: frame.midY - 510.0)
		btnOptions.title.fontSize = 75
		btnOptions.title.position.y += 3
		btnOptions.title.zPosition = 2
		btnOptions.zPosition = 98
		addChild(btnOptions)
		addChild(optionsScreen)
	}

	func animateLogo() {
		let logoAction = SKAction.scale(to: 1.00, duration: 0.75)
		logo.run(logoAction)
	}

	func actionPlay() {
		let gameSelectionMenu = GameSelectionMenu()
		gameSelectionMenu.scaleMode = .aspectFill
		view?.presentScene(gameSelectionMenu)
	}

	func actionGameCenter() {
		//GameKitHelper.sharedInstance.showGKGameCenterViewController(view?.window?.rootViewController)
	}

	func actionOptions() {
		optionsScreen.show()
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			if btnPlay.contains(location) {
				btnPlay.colorBlendFactor = 0.3
			} else {
				btnPlay.colorBlendFactor = 0.0
			}
			if btnGameCenter.contains(location) {
				btnGameCenter.colorBlendFactor = 0.3
			} else {
				btnGameCenter.colorBlendFactor = 0.0
			}
			if btnOptions.contains(location) {
				btnOptions.colorBlendFactor = 0.3
			} else {
				btnOptions.colorBlendFactor = 0.0
			}
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			if btnPlay.contains(location) {
				btnPlay.colorBlendFactor = 0.3
			}
			else if btnGameCenter.contains(location) {
				btnGameCenter.colorBlendFactor = 0.3
			}
			else if btnOptions.contains(location) {
				btnOptions.colorBlendFactor = 0.3
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch: AnyObject in touches {
			let location = touch.location(in: self)

			btnPlay.colorBlendFactor = 0.0
			btnGameCenter.colorBlendFactor = 0.0
			btnOptions.colorBlendFactor = 0.0

			if btnPlay.contains(location) {
				actionPlay()
			}
			else if btnGameCenter.contains(location) {
				actionGameCenter()
			}
			else if btnOptions.contains(location) {
				actionOptions()
			}
		}
	}
}

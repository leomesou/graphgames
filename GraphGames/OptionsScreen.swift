//
//  OptionsScreen.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class OptionsScreen: SKNode {

	let screenMenu = SKSpriteNode(imageNamed: "screenSettings")
	let btnReset   = GenericButton(titleName: "RESET PROGRESS")
	let btnSound   = GenericButton(titleName: "SOUND")
	let btnBack    = GenericButton(titleName: "BACK")

	let confirmationScreen = ConfirmationScreen()

	override init() {

		super.init()

		let blackView       = SKShapeNode(rectOf: screenSize)
		let screenTitle     = SKSpriteNode(imageNamed: "tile")
		let screenTitleText = SKLabelNode(fontNamed: font)

		blackView.fillColor = UIColor.black.withAlphaComponent(0.8)
		blackView.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		blackView.zPosition = 101

		screenMenu.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		screenMenu.zPosition = 102

		screenTitle.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 410)
		screenTitle.zPosition = 103

		screenTitleText.text      = "OPTIONS"
		screenTitleText.fontSize  = 100
		screenTitleText.fontColor = UIColor.white
		screenTitleText.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 380)
		screenTitleText.zPosition = 105

		btnReset.title.fontSize  = 70
		btnReset.position        = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 100)
		btnReset.zPosition       = 103
		btnReset.title.zPosition = 105
		btnSound.position        = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 50)
		btnSound.zPosition       = 103
		btnSound.title.zPosition = 105
		btnBack.position         = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 250)
		btnBack.zPosition        = 103
		btnBack.title.zPosition  = 105

		isHidden = true

		addChild(blackView)
		addChild(screenMenu)
		addChild(screenTitle)
		addChild(screenTitleText)

		addChild(confirmationScreen)

		addChild(btnReset)
		addChild(btnSound)
		addChild(btnBack)

		if let isSoundOn = userDefaultManager.getElementForKey("isSoundOn") as? Bool {
			if isSoundOn {
				btnSound.title.text = "SOUND: ON"
			}
			else {
				btnSound.title.text = "SOUND: OFF"
			}
		}
		else {
			userDefaultManager.saveElement(true as AnyObject, forkey: "isSoundOn")
			btnSound.title.text = "SOUND: ON"
		}

		isUserInteractionEnabled = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func show() {
		isHidden = false
	}

	func dismiss() {
		isHidden = true
	}

	func actionConfirm() {
		confirmationScreen.show()
	}

	func actionSound() {

		if let isSoundOn = userDefaultManager.getElementForKey("isSoundOn") as? Bool {
			if isSoundOn {
				userDefaultManager.saveElement(false as AnyObject, forkey: "isSoundOn")
				btnSound.title.text = "SOUND: OFF"
				//soundManager.pauseBackgroundSound()
			}
			else {
				userDefaultManager.saveElement(true as AnyObject, forkey: "isSoundOn")
				btnSound.title.text = "SOUND: ON"
				soundManager.playSound(Sound.connect)
				//soundManager.playBackgroundSound()
			}
		}
		else {
			userDefaultManager.saveElement(true as AnyObject, forkey: "isSoundOn")
			btnSound.title.text = "SOUND: ON"
			soundManager.playSound(Sound.connect)
			//soundManager.playBackgroundSound()
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnReset.contains(location) && !isHidden {
				btnReset.colorBlendFactor = 0.3
			}
			else if btnSound.contains(location) && !isHidden {
				btnSound.colorBlendFactor = 0.3
			}
			else if btnBack.contains(location) && !isHidden {
				btnBack.colorBlendFactor = 0.3
			}
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnReset.contains(location) && !isHidden {
				btnReset.colorBlendFactor = 0.3
			} else {
				btnReset.colorBlendFactor = 0.0
			}
			if btnSound.contains(location) && !isHidden {
				btnSound.colorBlendFactor = 0.3
			} else {
				btnSound.colorBlendFactor = 0.0
			}
			if btnBack.contains(location) && !isHidden {
				btnBack.colorBlendFactor = 0.3
			} else {
				btnBack.colorBlendFactor = 0.0
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			btnReset.colorBlendFactor = 0.0
			btnSound.colorBlendFactor = 0.0
			btnBack.colorBlendFactor  = 0.0

			if btnReset.contains(location) && !isHidden {
				actionConfirm()
			}
			else if btnSound.contains(location) && !isHidden {
				actionSound()
			}
			else if btnBack.contains(location) && !isHidden {
				dismiss()
			}
			else if !screenMenu.contains(location) && !isHidden {
				dismiss()
			}
		}
	}
}

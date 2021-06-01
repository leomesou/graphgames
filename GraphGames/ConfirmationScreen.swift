//
//  ConfirmationScreen.swift
//  GraphGames
//
//  Created by Leandro Sousa on 12/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class ConfirmationScreen: SKNode {

	let screenMenu = SKSpriteNode(imageNamed: "screenSettings")
	let btnYes     = GenericButton(titleName: "YES")
	let btnNo      = GenericButton(titleName: "NO")

	override init() {

		super.init()

		let blackView       = SKShapeNode(rectOf: CGSize(width: 768, height: 1024))
		let screenTitle     = SKSpriteNode(imageNamed: "tile")
		let screenTitleText = SKLabelNode(fontNamed: font)

		blackView.fillColor = UIColor.black.withAlphaComponent(0.8)
		blackView.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		blackView.zPosition = 201

		screenMenu.position    = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 50)
		screenMenu.size.height = 534
		screenMenu.zPosition   = 210

		screenTitle.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 130)
		screenTitle.zPosition = 211

		screenTitleText.text      = "ARE YOU SURE?"
		screenTitleText.fontSize  = 75
		screenTitleText.fontColor = UIColor.white
		screenTitleText.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 100)
		screenTitleText.zPosition = 212

		btnYes.position        = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 80)
		btnYes.zPosition       = 213
		btnYes.title.zPosition = 214
		btnNo.position         = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 230)
		btnNo.zPosition        = 213
		btnNo.title.zPosition  = 214

		isHidden = true

		addChild(blackView)
		addChild(screenMenu)
		addChild(screenTitle)
		addChild(screenTitleText)

		addChild(btnYes)
		addChild(btnNo)

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

	func actionReset() {
		plistManager.resetProgress()
		dismiss()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnYes.contains(location) && !isHidden {
				btnYes.colorBlendFactor = 0.3
			}
			else if btnNo.contains(location) && !isHidden {
				btnNo.colorBlendFactor = 0.3
			}
		}

	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			if btnYes.contains(location) && !isHidden {
				btnYes.colorBlendFactor = 0.3
			} else {
				btnYes.colorBlendFactor = 0.0
			}
			if btnNo.contains(location) && !isHidden {
				btnNo.colorBlendFactor = 0.3
			} else {
				btnNo.colorBlendFactor = 0.0
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			btnYes.colorBlendFactor   = 0.0
			btnNo.colorBlendFactor = 0.0

			if btnYes.contains(location) && !isHidden {
				actionReset()
			}
			else if btnNo.contains(location) && !isHidden {
				dismiss()
			}
			else if !screenMenu.contains(location) && !isHidden {
				dismiss()
			}
		}
	}
}

//
//  PauseScreen.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class PauseScreen: SKNode {
	
}
/*
	let btnHome   = HomeButton()
	let btnReload = ReloadButton()
	let btnPlay   = GenericButton(titleName: "BACK")
	
	override init() {
		
		let blackView = SKShapeNode(rectOfSize: screenSize)
		let screenMenu = SKSpriteNode(imageNamed: "screenSettings")
		let screenTitle = SKSpriteNode(imageNamed: "tile")
		let screenTitleText = SKLabelNode(fontNamed: font)
		
		blackView.fillColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
		blackView.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
		blackView.zPosition = 98
		
		screenMenu.position = CGPoint(x: screenSize.width/2 - 9, y: screenSize.height/2 + 274.5)
		screenMenu.zPosition = 102
		
		screenTitle.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 410)
		screenTitle.zPosition = 103
		
		screenTitleText.text = "PAUSE"
		screenTitleText.fontSize = 100
		screenTitleText.fontColor = UIColor(red:  255/255, green: 255/255, blue: 255/255, alpha: 1)
		screenTitleText.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 380)
		screenTitleText.zPosition = 105
		
		btnHome.position    = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 100)
		btnReload.position  = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 50)
		btnPlay.position    = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - 250)
		
		super.init()
		
		hidden = true
		
		addChild(blackView)
		addChild(screenMenu)
		addChild(screenTitle)
		addChild(screenTitleText)
		addChild(btnHome)
		addChild(btnReload)
		addChild(btnPlay)
		
		userInteractionEnabled = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func show() {
		hidden = false
	}
	
	func dismiss() {
		hidden = true
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let gameScene = parent?.scene as! GameScene
		
		if gameScene.isGamePaused {
			for touch in touches {
				let location = touch.locationInNode(self)
				
				if btnHome.containsPoint(location) && !hidden {
					btnHome.colorBlendFactor = 0.3
				}
				else if btnReload.containsPoint(location) && !hidden {
					btnReload.colorBlendFactor = 0.3
				}
				else if btnPlay.containsPoint(location) && !hidden {
					btnPlay.colorBlendFactor = 0.3
				}
			}
		}
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let gameScene = parent?.scene as! GameScene
		
		if gameScene.isGamePaused {
			for touch in touches {
				let location = touch.locationInNode(self)
				
				if btnHome.containsPoint(location) && !hidden {
					btnHome.colorBlendFactor = 0.3
				} else {
					btnHome.colorBlendFactor = 0.0
				}
				if btnReload.containsPoint(location) && !hidden {
					btnReload.colorBlendFactor = 0.3
				} else {
					btnReload.colorBlendFactor = 0.0
				}
				if btnPlay.containsPoint(location) && !hidden {
					btnPlay.colorBlendFactor = 0.3
				} else {
					btnPlay.colorBlendFactor = 0.0
				}
			}
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let gameScene = parent?.scene as! GameScene
		
		if gameScene.isGamePaused {
			for touch in touches {
				let location = touch.locationInNode(self)
				
				btnHome.colorBlendFactor   = 0.0
				btnReload.colorBlendFactor = 0.0
				btnPlay.colorBlendFactor   = 0.0
				
				if     btnHome.containsPoint(location) && !hidden {
					btnHome.goToHomeScreen()
				}
				else if btnReload.containsPoint(location) && !hidden {
					btnReload.resetGame()
				}
				else if btnPlay.containsPoint(location) && !hidden {
//					scene.hudManager.btnPause.continueGame()
					dismiss()
				}
			}
		}
	}
}
*/

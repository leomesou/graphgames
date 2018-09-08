//
//  GameViewController.swift
//  GraphGames
//
//  Created by Leandro Sousa on 14/03/16.
//  Copyright (c) 2016 Leandro Sousa. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	
	override func viewDidLoad() {
		
//		//GameCenter
//		NSNotificationCenter.defaultCenter().addObserver(self, selector:
//			Selector("showAuthenticationViewController"), name:
//			PresentAuthenticationViewController, object: nil)
//		GameKitHelper.sharedInstance.authenticateLocalPlayer()
		
		super.viewDidLoad()
		
		loadingScreen()
	}
	
	func loadingScreen() {
		let loadingScreen = LoadingScreen()
		loadingScreen.scaleMode = .aspectFill
		
		// Configure the view.
		let skView = self.view as! SKView
		skView.ignoresSiblingOrder = true
		
		skView.presentScene(loadingScreen)
	}
	
	override var shouldAutorotate : Bool {
		return true
	}
	
	override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override var prefersStatusBarHidden : Bool {
		return true
	}
	
	/*
	//GameCenter
	func showAuthenticationViewController() {
		
		let gameKitHelper = GameKitHelper.sharedInstance
		
		if let authenticationViewController = gameKitHelper.authenticationViewController {
			presentViewController(authenticationViewController, animated: true, completion: nil)
		}
	}
	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
	*/
}

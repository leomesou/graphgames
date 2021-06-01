//
//  GameKitHelper.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

//import GameKit
import Foundation

//let gameKit = GameKitHelper()
//let PresentAuthenticationViewController = "PresentAuthenticationViewController"

class GameKitHelper: NSObject {

}

/*
class GameKitHelper: NSObject, GKGameCenterControllerDelegate {

	enum Leaderboards: String {
		case highscore = "com.leomesou.GraphGames.Highscore"
	}

	var authenticationViewController: UIViewController?
	var lastError: NSError?
	var gameCenterEnabled: Bool

	class var sharedInstance: GameKitHelper {
		return gameKit
	}

	override init() {
		gameCenterEnabled = true
		super.init()
	}

	func reportAchievements(achievements: [GKAchievement]) {
		if !gameCenterEnabled {
			//Local player is not authenticated
			return
		}

		GKAchievement.reportAchievements(achievements) { (error) in
			self.lastError = error
		}
	}

	func authenticateLocalPlayer() {

		let localPlayer = GKLocalPlayer.localPlayer()

		localPlayer.authenticateHandler = { (viewController, error) in

			self.lastError = error

			if viewController != nil {
				self.authenticationViewController = viewController
				NSNotificationCenter.defaultCenter().postNotificationName(PresentAuthenticationViewController, object: self)
			}
			else if localPlayer.authenticated {
				self.gameCenterEnabled = true
			}
			else {
				self.gameCenterEnabled = false
			}
		}
	}

	func showGKGameCenterViewController(viewController: UIViewController!) {
		if !gameCenterEnabled {
			//Local player is not authenticated
			return
		}

		let gameCenterViewController = GKGameCenterViewController()
		gameCenterViewController.gameCenterDelegate = self

		gameCenterViewController.viewState = .Leaderboards

		viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
	}

	func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
		gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
	}

	func reportScore(score: Int, forLeaderBoardId leaderBoardId: String) {
		if !gameCenterEnabled {
			//"Local player is not authenticated"
			return
		}

		let scoreReporter = GKScore(leaderboardIdentifier: leaderBoardId)
		scoreReporter.value = Int64(score)
		scoreReporter.context = 0

		let scores = [scoreReporter]

		GKScore.reportScores(scores) { (error) in
			self.lastError = error
		}
	}
}
*/

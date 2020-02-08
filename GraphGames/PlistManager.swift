//
//  PlistManager.swift
//  GraphGames
//
//  Created by Leandro Sousa on 01/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import UIKit

let plistManager = PlistManager()

class PlistManager: NSObject {
	
	fileprivate let fileManager = FileManager.default
	fileprivate var path: String!
	var gameDataDict: NSMutableDictionary!
	var gameDefinitionsDict: NSMutableDictionary!
	
	func preparePlistForUse(_ nameFile: String) {
		let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
		let documentsDirectory = paths[0] as! String
		path = documentsDirectory + "/\(nameFile).plist"
		if (!fileManager.fileExists(atPath: path)) {
			if let bundlePath = Bundle.main.path(forResource: nameFile, ofType: "plist") {
				do {
					try fileManager.copyItem(atPath: bundlePath, toPath: path)
				}
				catch {
					print("Error preparing plist: ", error.localizedDescription)
				}
			}
		}
		do {
			let data = fileManager.contents(atPath: path)!
			if nameFile == "GameData" {
                try gameDataDict = PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? NSMutableDictionary
			}
			else if nameFile == "GameDefinitions" {
                try gameDefinitionsDict = PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? NSMutableDictionary
			}
		}
		catch {
			print("Error creating gamesDict: ", error.localizedDescription)
		}
	}
	
	func saveGame(_ gameNumber: Int, levelNumber: Int, levelState: LevelState) {
		
		let gameLevels = NSMutableArray(array: gameDataDict.value(forKey: "game\(gameNumber)") as! NSArray)
		
		gameLevels.replaceObject(at: levelNumber, with: levelState.rawValue)
		
		gameDataDict.setValue(gameLevels, forKey: "game\(gameNumber)")
		gameDataDict.write(toFile: path, atomically: true)
	}
	
	func resetProgress() {
		if (fileManager.fileExists(atPath: path)) {
			do {
				try fileManager.removeItem(atPath: path)
			}
			catch {
				print("Couldn't reset plist: ", error.localizedDescription)
			}
		}
		
		gameDataDict.removeAllObjects()
		let emptyArray = NSMutableArray(array: Array(repeating: 2, count: numberOfLevels))
		for gameNumber in 1...4 {
			gameDataDict.setValue(emptyArray, forKey: "game\(gameNumber)")
			plistManager.saveGame(gameNumber, levelNumber:  0, levelState: LevelState.empty)
		}
		gameDataDict.write(toFile: path, atomically: true)
	}
	
	
	//	func loadGameData() {
	//
	//		let levelsGame1 = [1,1,1]
	//		let levelsGame2 = [2,2,2]
	//		let levelsGame3 = [0,0,0]
	//
	//		gameDataDict.setValue(levelsGame1, forKey: "game1")
	//		gameDataDict.setValue(levelsGame2, forKey: "game2")
	//		gameDataDict.setValue(levelsGame3, forKey: "game3")
	//
	//		let game1Levels = gameDataDict.valueForKey("game1") as! NSMutableArray
	//		let game2Levels = gameDataDict.valueForKey("game2") as! NSMutableArray
	//		let game3Levels = gameDataDict.valueForKey("game3") as! NSMutableArray
	//
	//		print("Game1Levels --> \(game1Levels.description)")
	//		print("Game2Levels --> \(game2Levels.description)")
	//		print("Game3Levels --> \(game3Levels.description)")
	//
	//	}
}

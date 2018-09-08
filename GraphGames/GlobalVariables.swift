//
//  GlobalVariables.swift
//  GraphGames
//
//  Created by Leandro Sousa on 12/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

let font = "Helvetica"

let screenSize = CGSize(width: 1536.0, height: 2048.0)

let numberOfLevels = 30

enum LevelState: Int {
	case empty = 0
	case complete = 1
	case locked = 2
}

enum GameType: Int {
	case vertexCover = 1
	case edgeColoring = 2
	case edgeCover = 3
}

class GlobalVariables: NSObject {

}

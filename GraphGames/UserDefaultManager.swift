//
//  UserDefaultManager.swift
//  GraphGames
//
//  Created by Leandro Sousa on 15/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import UIKit

let userDefaultManager = UserDefaultManager()

class UserDefaultManager: NSObject {

	fileprivate let manager = UserDefaults.standard

	func saveElement(_ element: AnyObject, forkey key: String) {
		switch element {
		case let intValue as Int:
			manager.set(intValue, forKey: key)
		case let boolValue as Bool:
			manager.set(boolValue, forKey: key)
		default:
			break
		}
	}

	func getElementForKey(_ key: String) -> AnyObject? {
		return manager.object(forKey: key) as AnyObject?
	}
}

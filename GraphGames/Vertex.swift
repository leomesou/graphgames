//
//  Vertex.swift
//  GraphGames
//
//  Created by Leandro Sousa on 16/03/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class Vertex: SKShapeNode {

	var edgesConnected: [Int] = []
	var number: Int = 0

	override init() {

		super.init()

		let diameter: CGFloat = 120.0
		//let diameter: CGFloat = 150.0

		let rect = CGRect(origin: CGPoint(x: -diameter/2.0, y: -diameter/2.0), size: CGSize(width: diameter, height: diameter))

		path = CGPath(ellipseIn: rect, transform: nil)
		alpha = 1.0
		fillColor = UIColor.white
		strokeColor = UIColor.black
		lineWidth = 10.0
		zPosition = 3

		let minXVertex: CGFloat = 100 + 192
		let minYVertex: CGFloat = 100 + 250
		let maxXVertex: CGFloat = screenSize.width  - 100 - 192
		let maxYVertex: CGFloat = screenSize.height - 100 - 300
		let rangeXVertex = SKRange(lowerLimit: minXVertex, upperLimit: maxXVertex)
		let rangeYVertex = SKRange(lowerLimit: minYVertex, upperLimit: maxYVertex)
		constraints = [SKConstraint.positionX(rangeXVertex, y: rangeYVertex)]
		//print("RangeXVertex \(rangeXVertex)")
		//print("RangeYVertex \(rangeYVertex)")
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

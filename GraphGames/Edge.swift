//
//  Edge.swift
//  GraphGames
//
//  Created by Leandro Sousa on 20/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class Edge: SKShapeNode {

	var firstVertexNumber: Int
	var  lastVertexNumber: Int
	var crossed: Bool = false

	init(firstVertexNumber: Int, lastVertexNumber: Int) {
		self.firstVertexNumber = firstVertexNumber
		self.lastVertexNumber  =  lastVertexNumber
		super.init()

		lineWidth = 10
		strokeColor = UIColor.black

		let minXEdge: CGFloat = 0.00 //100 + 192
		let minYEdge: CGFloat = 0.00 //100 + 250
		let maxXEdge: CGFloat = screenSize.width  // - 100 - 192
		let maxYEdge: CGFloat = screenSize.height // - 100 - 300
		let rangeXEdge = SKRange(lowerLimit: minXEdge, upperLimit: maxXEdge)
		let rangeYEdge = SKRange(lowerLimit: minYEdge, upperLimit: maxYEdge)
		constraints = [SKConstraint.positionX(rangeXEdge, y: rangeYEdge)]
		//print("RangeXEdge \(rangeXEdge)")
		//print("RangeYEdge \(rangeYEdge)")
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

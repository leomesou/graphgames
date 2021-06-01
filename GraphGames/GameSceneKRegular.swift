//
//  GameSceneKRegular.swift
//  GraphGames
//
//  Created by Leandro Sousa on 21/06/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GameSceneKRegular: GameScene {

	let levelNumber: Int

	var hudManager: HudManager! {
		didSet {
			addChild(hudManager)
			hudManager.createLevelButtons()
			hudManager.createLabelDegree()
		}
	}

	var moveVertex = false {
		didSet {
			if moveVertex {
				hudManager.btnState.color = UIColor.blue
			}
			else {
				hudManager.btnState.color = UIColor.red
			}
		}
	}

	var allowEdge = false

	var degree: Int!
	var numberOfVertices: Int!
	let numberOfEdges = 0

	var vertices: [Vertex] = []
	var edges:    [Edge]   = []

	var firstPosition = CGPoint()
	var  lastPosition = CGPoint()

	var firstVertexNumber = Int()
	var  lastVertexNumber = Int()

	var tempEdge = SKShapeNode()

	init(level: Int) {
		levelNumber = level
		super.init(gameNumber: 2, level: levelNumber)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func didMove(to view: SKView) {

		createBackground()

		getPlistData()

		hudManager = HudManager()

		vertices = createVertices(numberOfVertices)

		placeVerticesRandomly()
	}

	func createBackground() {
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -1
		addChild(background)
	}

	func getPlistData() {
		let gameDefinitions = plistManager.gameDefinitionsDict.value(forKey: "kregular") as! NSMutableArray
		let values = gameDefinitions.object(at: levelNumber-1) as! NSArray
		numberOfVertices = values.object(at: 0) as? Int
		degree = values.object(at: 1) as? Int
	}

	func createVertices(_ numberOfVertices: Int) -> [Vertex] {
		var vertices: [Vertex] = []

		while vertices.count < numberOfVertices {
			vertices.append(Vertex())
			vertices.last?.number = vertices.endIndex-1
			addChild(vertices.last!)
		}
		return vertices
	}

	func placeVerticesRandomly() {

		let vertex = Vertex()
		let minX = 100 + 192 + vertex.frame.width/2
		let minY = 100 + 250 + vertex.frame.height/2
		let maxX = screenSize.width  - 100 - 192 - vertex.frame.width/2
		let maxY = screenSize.height - 100 - 300 - vertex.frame.height/2

		var index = 0
		while index < vertices.count {
			var intersects = true
			while intersects {

				let xPos = CGFloat(arc4random_uniform(UInt32(maxX - minX + 1))) + minX
				let yPos = CGFloat(arc4random_uniform(UInt32(maxY - minY + 1))) + minY

				vertices[index].position = CGPoint(x: xPos, y: yPos)

				intersects = detectIntersectionVertices(vertices[index])
			}

			index += 1
		}
	}

	func detectIntersectionVertices(_ currentVertex: Vertex) -> Bool {
		for oldVertex in vertices {
			if oldVertex.number == currentVertex.number {
				return false
			}
			else if currentVertex.intersects(oldVertex) {
				return true
			}
		}
		return false
	}

	func createVertexAnimation(_ vertexPosition: CGPoint) {
		let vertexToAnimate = SKShapeNode()
		let diameter: CGFloat = 120.0
		let rect = CGRect(origin: CGPoint(x: -diameter/2.0, y: -diameter/2.0), size: CGSize(width: diameter, height: diameter))

		vertexToAnimate.path = CGPath(ellipseIn: rect, transform: nil)
		vertexToAnimate.alpha = 1.0
		vertexToAnimate.fillColor = UIColor.white
		vertexToAnimate.strokeColor = UIColor.black
		vertexToAnimate.lineWidth = 10.0
		vertexToAnimate.zPosition = 3
		vertexToAnimate.position = vertexPosition
		addChild(vertexToAnimate)

		animateVertex(vertexToAnimate)
	}

	func animateVertex(_ vertex: SKShapeNode) {
		let resize    = SKAction.scale(to: 1.10, duration: 0.050)
		let fadeOut   = SKAction.fadeAlpha(to: 0.0, duration: 0.050)
		let animation = SKAction.sequence([resize, fadeOut])

		vertex.run(animation)
	}

	func createTempEdge(_ firstPosition: CGPoint, lastPosition: CGPoint) -> SKShapeNode {
		let edge = SKShapeNode()
		let pathToDraw = CGMutablePath()
		pathToDraw.move   (to: CGPoint(x: firstPosition.x, y: firstPosition.y))
		pathToDraw.addLine(to: CGPoint(x:  lastPosition.x, y:  lastPosition.y))
		edge.path = pathToDraw
		edge.lineWidth = 10
		edge.strokeColor = UIColor.black
		return edge
	}

	func createEdge(_ firstVertexNumber: Int, lastVertexNumber: Int) -> Edge {
		let edge = Edge(firstVertexNumber: firstVertexNumber, lastVertexNumber: lastVertexNumber)
		let pathToDraw = CGMutablePath()
		pathToDraw.move   (to: CGPoint(x: vertices[firstVertexNumber].position.x, y: vertices[firstVertexNumber].position.y))
		pathToDraw.addLine(to: CGPoint(x: vertices[ lastVertexNumber].position.x, y: vertices[ lastVertexNumber].position.y))
		edge.path = pathToDraw
		return edge
	}

	func compareEdges(_ edge1: Edge, edge2: Edge) -> Bool {
		if    edge1.firstVertexNumber == edge2.firstVertexNumber {
			if edge1.lastVertexNumber ==  edge2.lastVertexNumber {
				return true
			}
		}
		else if edge1.firstVertexNumber ==  edge2.lastVertexNumber {
			if  edge1.lastVertexNumber == edge2.firstVertexNumber {
				return true
			}
		}
		return false
	}

	func updateEdgesLocation(_ vertexNumber: Int) {
		for edgeNumber in vertices[vertexNumber].edgesConnected {

			var newEdge = createEdge(edges[edgeNumber].firstVertexNumber, lastVertexNumber: vertexNumber)

			if newEdge.frame == CGRect.zero {
				newEdge = createEdge(vertexNumber, lastVertexNumber:  edges[edgeNumber].lastVertexNumber)
			}

			newEdge.strokeColor = edges[edgeNumber].strokeColor

			let index = vertices[vertexNumber].edgesConnected.firstIndex(of: edgeNumber)
			vertices[vertexNumber].edgesConnected.remove(at: index!)
			edges[edgeNumber].removeFromParent()
			edges.remove(at: edgeNumber)

			edges.insert(newEdge, at: edgeNumber)
			vertices[vertexNumber].edgesConnected.append(edgeNumber)
			addChild(edges[edgeNumber])
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			//if touch.tapCount == 2 {
			//	moveVertex = !moveVertex
			//}

			if !moveVertex {
				if let vertex = self.atPoint(location) as? Vertex {

					firstVertexNumber = vertex.number
					firstPosition = vertices[firstVertexNumber].position

					allowEdge = true

					createVertexAnimation(vertex.position)
				}
			}
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

		for touch in touches {
			let location = touch.location(in: self)

			tempEdge.removeFromParent()

			if moveVertex {
				if let vertex = self.atPoint(location) as? Vertex {

					lastVertexNumber = vertex.number
					lastPosition = location
					vertices[lastVertexNumber].position = location

					updateEdgesLocation(lastVertexNumber)
				}
			}
			else {
				if allowEdge {
					if vertices[firstVertexNumber].edgesConnected.count < degree {
						tempEdge = createTempEdge(firstPosition, lastPosition: location)
						self.addChild(tempEdge)
					}
				}
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		allowEdge = false

		for touch in touches {
			let location = touch.location(in: self)

			if moveVertex {
				if let vertex = self.atPoint(location) as? Vertex {

					lastVertexNumber = vertex.number
					lastPosition = location
					vertices[lastVertexNumber].position = location

					updateEdgesLocation(lastVertexNumber)
				}
			}
			else {
				if let vertex = self.atPoint(location) as? Vertex {

					lastVertexNumber = vertex.number
					lastPosition = vertices[lastVertexNumber].position

					if firstPosition == lastPosition {

					}
					else {
						tempEdge.removeFromParent()

						//impedir que se crie mais arestas do que o limite do grau dos vértices
						if vertices[firstVertexNumber].edgesConnected.count < degree &&
							vertices[ lastVertexNumber].edgesConnected.count < degree {

							let permEdge = createEdge(firstVertexNumber, lastVertexNumber: lastVertexNumber)

							var edgeExists = false
							for edge in edges {
								if compareEdges(permEdge, edge2: edge) {
									edgeExists = true
									break
								}
							}

							if !edgeExists {
								edges.append(permEdge)
								vertices[firstVertexNumber].edgesConnected.append(edges.endIndex-1)
								vertices[ lastVertexNumber].edgesConnected.append(edges.endIndex-1)
								addChild((edges.last)!)
							}

							createVertexAnimation(vertex.position)
						}
					}
				}
				else {
					tempEdge.removeFromParent()
				}
			}
		}

		if isKRegular() {
			endGame()
		}

		//for vertex in vertices {
		//	print("Vertex \(vertex.number): \(vertex.edgesConnected)")
		//}
		//print()
	}

	func isKRegular() -> Bool {
		for vertex in vertices {
			if vertex.edgesConnected.count != degree {
				return false
			}
		}
		return true
	}

	func endGame() {
		//setar o level atual como concluído
		plistManager.saveGame(gameNumber, levelNumber: levelNumber-1, levelState: LevelState.complete)

		//desbloquear o level seguinte se esse não estiver completo ou for o último
		if levelNumber < numberOfLevels {
			let gameLevels = plistManager.gameDataDict.value(forKey: "game\(gameNumber)") as! NSMutableArray
			let nextLevelState = gameLevels.object(at: levelNumber) as! Int
			if nextLevelState == 2 { //LevelState.Locked
				plistManager.saveGame(gameNumber, levelNumber: levelNumber, levelState: LevelState.empty)
			}
		}
		hudManager.postGameScreen.show()
	}
}

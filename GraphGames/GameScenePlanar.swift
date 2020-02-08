//
//  GameScenePlanar.swift
//  GraphGames
//
//  Created by Leandro Sousa on 21/06/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import SpriteKit

class GameScenePlanar: GameScene {
	
	let levelNumber: Int
	
	var hudManager: HudManager! {
		didSet {
			addChild(hudManager)
			hudManager.createLevelButtons()
		}
	}
	
	var numberOfVertices: Int!
	var numberOfEdges: Int!
	
	var vertices: [Vertex] = []
	var edges:    [Edge]   = []
	
	init(level: Int) {
		self.levelNumber = level
		super.init(gameNumber: 1, level: level)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMove(to view: SKView) {
		
		createBackground()
		
		hudManager = HudManager()
		hudManager.btnState.isHidden = true
		
		getPlistData()
		
		vertices = createVertices(numberOfVertices)
		
		connectVertices()
		
		generateGraphNotPlanar()
	}
	
	func createBackground() {
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -1
		addChild(background)
	}
	
	func getPlistData() {
		let gameDefinitions = plistManager.gameDefinitionsDict.value(forKey: "planar") as! NSMutableArray
		
		let values = gameDefinitions.object(at: levelNumber-1) as! NSArray
        numberOfVertices = values.object(at: 0) as? Int
        numberOfEdges = values.object(at: 1) as? Int
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
	
	func connectVertices() {
		var vertexDisconnected: Bool
		repeat {
			vertexDisconnected = false
			
			edges = generateRamdomEdges(numberOfVertices, optionalEdgesNumber: numberOfEdges)
			
			for vertex in vertices {
				if vertex.edgesConnected.count == 0 {
					vertexDisconnected = true
					break
				}
			}
		} while vertexDisconnected
	}
	
	func generateGraphNotPlanar() {
		repeat {
			placeVerticesRandomly()
			
			for vertexNumber in 0...numberOfVertices-1 {
				updateEdgesLocation(vertexNumber)
			}
			
			showCrossings()
			
		} while isPlanar()
	}
	
	func placeVerticesRandomly() {
		
		let minX: CGFloat = 100 + 192 + Vertex().frame.width/2
		let minY: CGFloat = 100 + 250 + Vertex().frame.height/2
		let maxX: CGFloat = screenSize.width  - 100 - 192 - Vertex().frame.width/2
		let maxY: CGFloat = screenSize.height - 100 - 300 - Vertex().frame.height/2
		
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
	
	func generateRamdomEdges(_ verticesNumber: Int, optionalEdgesNumber: Int?) -> [Edge] {
		let maxEdges = (verticesNumber*(verticesNumber-1))/2
		let edgesNumber: Int
		if optionalEdgesNumber == nil {
			edgesNumber = Int(arc4random_uniform(UInt32(maxEdges+1)))
		}
		else {
			edgesNumber = optionalEdgesNumber!
		}
		var edges: [Edge] = []
		while edges.count < edgesNumber {
			let firstVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			var  lastVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			while lastVertex == firstVertex {
				lastVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			}
			let edge = createEdge(firstVertex, lastVertexNumber: lastVertex)
			let edgeInverted = createEdge(lastVertex, lastVertexNumber: firstVertex)
			if !(edges.contains(edge) || edges.contains(edgeInverted)) {
				edges.append(edge)
				vertices[firstVertex].edgesConnected.append(edges.endIndex-1)
				vertices[ lastVertex].edgesConnected.append(edges.endIndex-1)
				addChild(edges.last!)
			}
		}
		return edges
	}
	
	func createEdge(_ firstVertexNumber: Int, lastVertexNumber: Int) -> Edge {
		let edge = Edge(firstVertexNumber: firstVertexNumber, lastVertexNumber: lastVertexNumber)
		let pathToDraw = CGMutablePath()
		pathToDraw.move   (to: CGPoint(x: vertices[firstVertexNumber].position.x, y: vertices[firstVertexNumber].position.y))
		pathToDraw.addLine(to: CGPoint(x: vertices[ lastVertexNumber].position.x, y: vertices[ lastVertexNumber].position.y))
		edge.path = pathToDraw
		return edge
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
	
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		for touch in touches {
			let location = touch.location(in: self)
			
			if let vertex = self.atPoint(location) as? Vertex {
				
				vertices[vertex.number].position = location
				updateEdgesLocation(vertex.number)
			}
		}
		showCrossings()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		for touch in touches {
			let location = touch.location(in: self)
			
			if let vertex = self.atPoint(location) as? Vertex {
				
				vertices[vertex.number].position = location
				updateEdgesLocation(vertex.number)
			}
		}
		showCrossings()
		
		if isPlanar() {
			print("planar")
//			endGame()
		}
	}
	
	func showCrossings() {
		for edge in edges {
			edge.strokeColor = UIColor.black
			edge.crossed = false
		}
		for edge1 in edges {
			for edge2 in edges {
				if  edge1.firstVertexNumber != edge2.firstVertexNumber &&
					edge1.firstVertexNumber != edge2.lastVertexNumber  &&
					edge1.lastVertexNumber  != edge2.firstVertexNumber &&
					edge1.lastVertexNumber  != edge2.lastVertexNumber {
					
					if edgesIntersect(edge1, edge2: edge2) {
						edge1.strokeColor = UIColor.blue
						edge2.strokeColor = UIColor.blue
						edge1.crossed = true
						edge2.crossed = true
					}
				}
			}
		}
	}
	
	// Determina se as arestas AB e CD se cruzam
	func edgesIntersect(_ edge1: Edge, edge2: Edge) -> Bool {
		
		let a = vertices[edge1.firstVertexNumber].position
		let b = vertices[edge1.lastVertexNumber].position
		let c = vertices[edge2.firstVertexNumber].position
		let d = vertices[edge2.lastVertexNumber].position
		
		let CmP = CGPoint(x: c.x - a.x, y: c.y - a.y)
		let r   = CGPoint(x: b.x - a.x, y: b.y - a.y)
		let s   = CGPoint(x: d.x - c.x, y: d.y - c.y)
		
		let CmPxr = CmP.x * r.y - CmP.y * r.x
		let CmPxs = CmP.x * s.y - CmP.y * s.x
		let rxs   =   r.x * s.y -   r.y - s.x
		
		if CmPxr == 0.0 {
			// Arestas colineares, se cruzam se forem sobrepostas
			if ((c.x - a.x < 0.0) != (c.x - b.x < 0.0)) || ((c.y - a.y < 0.0) != (c.y - b.y < 0.0)) {
				return true
			}
			else {
				return false
			}
		}
		
		if rxs == 0.0 {
			// Arestas paralelas
			return false
		}
		
		let rxsr = 1.0 / rxs
		let t = CmPxr * rxsr
		let u = CmPxs * rxsr
		
		if (t >= 0.0) && (t <= 1.0) && (u >= 0.0) && (u <= 1.0) {
			return true
		}
		else {
			return false
		}
	}
	
	func isPlanar() -> Bool {
		for edge in edges {
			if edge.crossed {
				return false
			}
		}
		return true
	}
	
	func endGame() {
		// Setar o level atual como concluído
		plistManager.saveGame(gameNumber, levelNumber: levelNumber-1, levelState: LevelState.complete)
		
		// Desbloquear o level seguinte se esse não estiver completo ou for o último
		if levelNumber < numberOfLevels {
			let gameLevels = plistManager.gameDataDict.value(forKey: "game\(gameNumber)") as! NSMutableArray
			let nextLevelState = gameLevels.object(at: levelNumber) as! Int
			if nextLevelState == 2 { // LevelState.Locked
				plistManager.saveGame(gameNumber, levelNumber: levelNumber, levelState: LevelState.empty)
			}
		}
		hudManager.postGameScreen.show()
	}
}

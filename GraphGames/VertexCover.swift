//
//  VertexCover.swift
//  GraphGames
//
//  Created by Leandro Sousa on 19/04/16.
//  Copyright © 2016 Leandro Sousa. All rights reserved.
//

import UIKit

class VertexCover: NSObject {
	
	func verifyEdgeCoverComplete(_ vertices: [Vertex]) -> Bool {
		for vertex in vertices {
			if vertex.edgesConnected == [] {
				return false
			}
		}
		return true
	}
	
//	func verifyEdgeCoverPerfect(vertices: [Vertex]) -> Bool {
//		for vertex in vertices {
//			if vertex.edgesConnected == [] {
//				return false
//			}
//		}
//		return true
//	}
	
	func verifyVertexCoverComplete(_ edges: [Edge], selectedVertices: [Int]) -> Bool {
		for edge in edges {
			if !(selectedVertices.contains(edge.firstVertexNumber) ||
				 selectedVertices.contains(edge.lastVertexNumber)) {
				return false
			}
		}
		return true
	}
	
//	func verifyVertexCoverPerfect(edges: [Edge]) -> Bool {
//		for edge in edges {
//			if edge....... {
//				return false
//			}
//		}
//		return true
//	}
	
	func approximationVertexCover(_ edges: [Edge]) -> [Edge] {
		var cover: [Edge] = []
		var edges = edges
		
		while edges != [] {
			let edge = returnAleatoryEdge(edges)
			cover.append(edge)
			edges = removeEdges(edge, fromEdges: edges)
		}
		return cover
	}
	
	func returnAleatoryEdge(_ edges: [Edge]) -> Edge {
		let randomIndex = Int(arc4random_uniform(UInt32(edges.count)))
		return edges[randomIndex]
	}
	
	func removeEdges(_ edge: Edge, fromEdges: [Edge]) -> [Edge] {
		var edges = fromEdges
		for edgeInArray in edges {
			if edgeInArray.firstVertexNumber == edge.firstVertexNumber {
				edges.remove(at: edges.index(of: edgeInArray)!)
			}
			else if edgeInArray.firstVertexNumber == edge.lastVertexNumber {
				edges.remove(at: edges.index(of: edgeInArray)!)
			}
			else if edgeInArray.lastVertexNumber == edge.firstVertexNumber {
				edges.remove(at: edges.index(of: edgeInArray)!)
			}
			else if edgeInArray.lastVertexNumber == edge.lastVertexNumber {
				edges.remove(at: edges.index(of: edgeInArray)!)
			}
		}
		return edges
	}
	
	func generateRamdomEdges(_ verticesNumber: Int) -> [Edge] {
		let maxEdges = maxNumber(verticesNumber-1)
		let edgesNumber = Int(arc4random_uniform(UInt32(maxEdges)))
		
		var edges: [Edge] = []
		while edges.count < edgesNumber {
			let firstVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			var  lastVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			while lastVertex == firstVertex {
				 lastVertex = Int(arc4random_uniform(UInt32(verticesNumber)))
			}
			let edge = Edge(firstVertexNumber: firstVertex, lastVertexNumber: lastVertex)
			let edgeInverted = Edge(firstVertexNumber: lastVertex, lastVertexNumber: firstVertex)
			if !(edges.contains(edge) || edges.contains(edgeInverted)) {
				edges.append(edge)
			}
		}
		return edges
	}
	
	
	func maxNumber(_ number: Int) -> Int {
		if number == 1 {
			return 1
		}
		else {
			return number + maxNumber(number - 1)
		}
	}
}

	/*
	func OptimalVertexCover (vertices: [Vertex], edges: [Edge]) {
		var vertices = vertices
		var edges = edges
		for vertex in vertices {
			for ........ {
				edges = removeEdges(....., fromEdges: edges)
	
		para cada v em V' {
			para cada permutacao de V', de tamanho 1 a n {
				E'' = E'
				para cada vertice da permutacao {
					E'' = E'' - (u,X)
				}
				para toda aresta incidente a v {
					E'' = E'' - (v,X)
				}
			return C
			}
		}
	}
	*/
	

/*
	func APPROXIMATIONVERTEXCOVER(G : Graph) {
		var C = ∅
		var E'= G.E

		while E'≠ ∅ {
			let (u, v) be an arbitrary edge of E'
			C = C ∪ {u, v}
			remove from E' every edge incident on either u or v
		}
		return C
	}
*/

//labels para criar componentes
//Construa um grafo com x componentes

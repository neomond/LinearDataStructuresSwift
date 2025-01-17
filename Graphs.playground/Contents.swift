// MARK: - Docs Graphs are a way of modeling systems based on a node and edge structure for representing the relationships between items.
// Graphs are not bounded by the parent-children relationship.

// Graphs -  are an essential data structure in computer science for modeling networks. Let’s review some key terms:
//           vertex: A node in a graph.
//           edge: A connection between two vertices.
//           adjacent: When an edge exists between vertices.
//           path: A sequence of one or more edges between vertices.
//           disconnected: Graph where at least two vertices have no path connecting them.
//           weighted: Graph where edges have an associated cost.
//           directed: Graph where travel between vertices can be restricted to a single direction.
//           cycle: A path which begins and ends at the same vertex.
//           adjacency matrix: Graph representation where vertices are both the rows and the columns. Each cell represents a possible edge.
//           adjacency list: Graph representation where each vertex has a list of all the vertices it shares an edge with.

// MARK: - Acyclic Graphs -
//           are graphs that do not contain a graph cycle. (This means that as you traverse the graph, once you leave a node, there is no path back to that node.)

// MARK: - Cyclic Graphs -
//           are graphs that contain at least one cycle. (This means that as you traverse the graph, somewhere in the graph, it is possible to leave a node and return to that same node through the cycle.)

// MARK: - Review
//           Acyclic graphs: A graph is acyclic if there are no graph cycles. Acyclic graphs had no change to the base implementation.
//           Cyclic graphs: A graph is cyclic if there is at least one graph cycle. Cyclic graphs also did not change the base implementation. This graph, however, greatly changes how to search graphs (you’ll see this in future lessons!)
//           Undirected graphs: Since undirected graphs can travel in both directions from node to node, bidirectional edge support was implemented.
//           Directed graphs: Directed graphs are graphs that dictate the direction in which edges can be traversed. This changed bidirectional support to be an optional request instead of a requirement.
//           Weighted graphs: Weighted graphs provide a numeric value to edges. Since weights are not a requirement when building graphs, our implementation included overloading functions to ensure multiple uses of adding an edge to a graph existed.


class GraphNode {
    
  var data: String
  var neighboringNodes: [GraphNode]
  
  init(data: String) {
      self.data = data
      self.neighboringNodes = []
  }
  
  func addNeighbor(_ newNeighbor: GraphNode) {
      neighboringNodes.append(newNeighbor)
  }
  
  func removeNeighbor(_ nodeToRemove: GraphNode) {
    if let index = neighboringNodes.firstIndex(where: { $0 == nodeToRemove }) {
      neighboringNodes.remove(at: index)
    }
  }
}
extension GraphNode: Equatable {
  static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
      return lhs === rhs
  }
}
extension GraphNode: CustomStringConvertible {
  var description: String {
      return "\(data)"
  }
}

struct GraphEdge {
  let nodeOne: GraphNode
  let nodeTwo: GraphNode
  var weight: Int? = nil
  
  init(nodeOne: GraphNode, nodeTwo: GraphNode, weight: Int? = nil) {
    self.nodeOne = nodeOne
    self.nodeTwo = nodeTwo
    self.weight = weight
  }
}

class Graph {
  var nodes: [GraphNode]
  var edges: [GraphEdge]
    
  init(nodes: [GraphNode]) {
    self.nodes = nodes
    edges = []
  }

  func addEdge(from nodeOne: GraphNode,
               to nodeTwo: GraphNode,
               isBidirectional: Bool = true,
               weight: Int? = nil) {
    edges.append(GraphEdge(nodeOne: nodeOne, nodeTwo: nodeTwo, weight: weight))
    nodeOne.addNeighbor(nodeTwo)
    if(isBidirectional==true) {
      edges.append(GraphEdge(nodeOne: nodeTwo, nodeTwo: nodeOne, weight: weight))
      nodeTwo.addNeighbor(nodeOne)
    }
  }
  
  func addEdges(from nodeOne: GraphNode, to neighboringNodes: [(node: GraphNode, isBidirectional: Bool, weight: Int?)]) {
    for (node, isBidirectional, weight) in neighboringNodes {
      addEdge(from: nodeOne, to: node, isBidirectional: isBidirectional, weight: weight)
    }
  }

  func removeNode(_ node: GraphNode) {
    if let index = nodes.firstIndex(where: { $0 == node }) {
      nodes.remove(at: index)
    }
    
    edges = edges.filter { $0.nodeOne != node || $0.nodeTwo != node }
    nodes.forEach { $0.removeNeighbor(node) }
  }
  
  func printGraph() {
    for node in nodes {
      Swift.print("\(node): \(node.neighboringNodes)")
    }
  }
}


let atlanta = GraphNode(data: "Atlanta")
let newYork = GraphNode(data: "New York")
let chicago = GraphNode(data: "Chicago")
let orlando = GraphNode(data: "Orlando")
let losAngeles = GraphNode(data: "Los Angeles")
let graph = Graph(nodes: [atlanta, newYork, chicago, orlando, losAngeles])

graph.addEdges(from: atlanta, to: [(node: newYork, isBidirectional: false, weight: 250), (node: orlando, isBidirectional: false, weight: 80)])
graph.addEdges(from: orlando, to: [(node: atlanta, isBidirectional: false, weight: 100), (node: newYork, isBidirectional: false, weight: 400), (node: chicago, isBidirectional: false, weight: 200)])
graph.addEdges(from: losAngeles, to: [(node: chicago, isBidirectional: false, weight: 125), (node: atlanta, isBidirectional: false, weight:250)])
graph.addEdge(from: chicago, to: newYork, isBidirectional: false, weight: 190)
graph.addEdges(from: newYork, to: [(node: losAngeles, isBidirectional: false, weight: 400), (node: atlanta, isBidirectional: false, weight: 200)])


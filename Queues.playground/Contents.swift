
// MARK: - QUEUES

// A queue is a data structure which contains an ordered set of data.
//*         Contain data nodes
//*         Queues process data First In, First Out (FIFO)
//*         Support three main operations: Enqueue, Dequeue, Peek

//*         Enqueue adds data to the back of the queue
//*         Dequeue removes and provides data from the front of the queue
//*         Peek provides data on the front of the queue

//*         Can be implemented using a linked list or array
//*         Bounded queues have a limited size.
//*         Enqueueing onto a full queue causes a queue overflow
//*         Dequeue data from an empty queue, will result in a queue underflow.

//*         Traversals and modifications are disallowed (using linked lists)
//*         Both head and tail should have references (using linked lists)

import UIKit

class Node {
    var data: String
    var next: Node?
    
    init(data: String) {
        self.data = data
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        return data + " -> " + (next?.description ?? "nil")
    }
}

struct Queue {
    var head: Node?
    var tail: Node?
    
    //    MARK: - PEEK
    func peek() -> String {
        return head?.data ?? "Default Value"
    }
    
    //    MARK: - ENQUEUE
    mutating func enqueue(_ data: String) {
        let newNode = Node(data: data)
        
        guard let lastNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        lastNode.next = newNode
        tail = newNode
    }
    
    //    MARK: - DEQUEUE
    mutating func dequeue() -> String? {
        var removedNode: String?
        
        if let firstNode = head {
            removedNode = firstNode.data
        }
        
        head = head?.next
        return removedNode
    }
}


extension Queue: CustomStringConvertible {
    var description: String {
        guard let firstNode = head else { return "Nothing in the queue" }
        return "(Front) \(firstNode) (Back)"
    }
}

var myQueue = Queue()
print(myQueue)
print(myQueue.enqueue("first"))
print(myQueue.enqueue("second"))
print(myQueue)
print(myQueue.peek())
print(myQueue.dequeue() ?? "")

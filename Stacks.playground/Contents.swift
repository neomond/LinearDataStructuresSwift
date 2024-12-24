
// MARK: - Stacks

// A stack is a data structure which contains an ordered set of data.
// This is a Last In, First Out or LIFO structure. A less frequently used term is First In, Last Out, or FILO.

// Stacks provide three methods for interaction:
//*         Push - adds data to the “top” of the stack
//*         Pop - returns and removes data from the “top” of the stack
//*         Peek - returns data from the “top” of the stack without removing it
//

// Attempting to push data onto an already full stack will result in a stack overflow. Similarly, if you attempt to pop data from an empty stack, it will result in a stack underflow.


class LinkedList {
  class Node {
    var data: String
    var next: Node?
    init(data: String) {
      self.data = data
    }
  }
  var head: Node?
  var tail: Node?
  func addToHead(_ data: String) {
    let newHead = Node(data: data)
      let current = head
      head = newHead
      if current != nil {
        head?.next = current
      }
  }

  func removeHead() -> Node? {
    let removedHead = head
      if removedHead != nil {
        head = removedHead?.next
        removedHead?.next = nil
      }
    return removedHead
  }
}

struct Stack {
  private let list = LinkedList()
  private var size = 0
  private var maxSize: Int
  
  init(maxSize: Int = 2) {
    self.maxSize = maxSize
  }

  var isEmpty: Bool { //prevents stack overflow.
    return size == 0
    // return list.head == nil
  }
  
  mutating func push(_ str: String) {
    guard size < maxSize else {
      print("The stack is full! No room to add \(str).")
      return
    }
    size += 1
    list.addToHead(str)
    print("Added \(str)!")
  }
  
  func peek() -> String? {
    guard let node = list.head else { return nil }
    return node.data
  }

  mutating func pop() -> String? {
    guard let node = list.removeHead() else {
      print("Nothing left to remove!")
      return nil
    }
    size -= 1
    print("Removed \(node.data)!")
    return node.data
  }
}

var dishes = Stack()
dishes.push("blue plate")
dishes.push("white plate")
dishes.push("yellow plate")
print("Top dish: \(dishes.peek() ?? "Empty list")")
_ = dishes.pop()
_ = dishes.pop()
_ = dishes.pop()
_ = dishes.pop()

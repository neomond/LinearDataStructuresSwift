//
//  HASH MAPS: CONCEPTUAL

//  A hash map is:
//
//  Built on top of an array using a special indexing system.
//  A key-value storage with fast assignments and lookup.
//  A table that represents a map from a set of keys to a set of values.
//  Hash maps accomplish all this by using a hash function, which turns a key into an index into the underlying array.
//
//  A hash collision is when a hash function returns the same index for two different keys.
//
//  There are different hash collision strategies. Two important ones are separate chaining, where each array index points to a different data structure, and   open addressing, where a collision triggers a probing sequence to find where to store the value for a given key.


//  Hash map: A key-value store that uses an array and a hashing function to save and retrieve values.
//  Key: The identifier given to a value for later retrieval.
//  Hash function: A function that takes some input and returns a number.
//  Compression function: A function that transforms its inputs into some smaller range of possible outputs.
//
//  Recipe for saving to a hash table:
//  - Take the key and plug it into the hash function, getting the hash code.
//  - Modulo that hash code by the length of the underlying array, getting an array index.
//  - Check if the array at that index is empty, if so, save the value (and the key) there.
//  - If the array is full at that index continue to the next possible position depending on your collision strategy.
//
//  Recipe for retrieving from a hash table:
//  - Take the key and plug it into the hash function, getting the hash code.
//  - Modulo that hash code by the length of the underlying array, getting an array index.
//  - Check if the array at that index has contents, if so, check the key saved there.
//  - If the key matches the one you're looking for, return the value.
//  - If the keys don't match, continue to the next position depending on your collision strategy.


/// Hash maps provide O(1) average time complexity for these operations, making them ideal for performance-critical applications.
/// A hash table is a data structure that stores an arbitrary number of items, mapping keys to values, and uses a hash function to compute an index.


//
// HASH TABLES: CONCEPTUAL -----------------------

// The hashing function is the secret to efficiently storing and retrieving values in a hash table. A hashing function takes a value, passes it through a formula, and produces a result called a hash.


struct HashTable {
    private var values: [String]
    
    public init(capacity: Int) {
        values = Array(repeating: "", count: capacity)
    }
    
    private func index(for key: String) -> Int {
        return abs(key.hashValue) % values.count
    }
    
    public subscript(key: String) -> String? {
        set {
            if let value = newValue {
                update(value: value, for: key)
            } else {
                removeValue(for: key)
            }
        }
        get {
            return value(for: key)
        }
    }
    
    // MARK: - retrieve the values
    private func value(for key: String) -> String {
        let elementIndex = index(for: key)
        return values[elementIndex]
    }
    
    // MARK: -  assign a value
    private mutating func update(value: String, for key: String) {
        let elementIndex = index(for: key)
        values[elementIndex] = value
    }
    
    // MARK: - deleting elements
    private mutating func removeValue(for key: String) {
        let elementIndex = index(for: key)
        return values[elementIndex] = ""
    }
}

var hashTable = HashTable(capacity: 5)
hashTable["Thor"] = "Strongest Avenger"
hashTable["Thor"] = nil
print(hashTable["Thor"]!) // Should Print: ""



// MARK: - Collisions: Assign, Retrieve, Delete
//struct HashTable {
//    // 1 - 2
//    private var buckets: [[(String, String)]]
//    
//    public init(capacity: Int) {
//        // 1
//        buckets = Array(repeating: [], count: capacity)
//    }
//    
//    private func index(for key: String) -> Int {
//        // 2
//        return abs(key.hashValue) % buckets.count
//    }
//    
//    public subscript(key: String) -> String? {
//        set {
//            if let value = newValue {
//                update(value: value, for: key)
//            } else {
//                removeValue(for: key)
//            }
//        }
//        get {
//            return value(for: key)
//        }
//    }
//    
//    
//    private func value(for key: String) -> String {
//        let bucketIndex = index(for: key)
//        if let (_, currentValue) = buckets[bucketIndex].enumerated().first(where: { $0.element.0 == key}) {
//            return currentValue.1
//        }
//        return ""
//    }
//    
//    
//    
//    private mutating func update(value: String, for key: String) {
//        let bucketIndex = index(for: key)
//        if let (elementIndex, _) = buckets[bucketIndex].enumerated().first(where: { $0.element.0 == key}) {
//            buckets[bucketIndex][elementIndex] = (key, value)
//        }  else {
//            buckets[bucketIndex].append((key, value))
//        }
//        
//        
//        
//        private mutating func removeValue(for key: String) {
//            let bucketIndex = index(for: key)
//            if let (elementIndex, _) = buckets[bucketIndex].enumerated().first(where: { $0.element.0 == key}){
//                buckets[bucketIndex].remove(at: elementIndex)
//            }
//        }
//    }
//}

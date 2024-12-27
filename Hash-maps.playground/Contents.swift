
// MARK: - Hash Map Methodology

/// A hash table is a data structure that stores an arbitrary number of items, mapping keys to values, and uses a hash function to compute an index.
/// A hash map is a data structure that stores key-value pairs. It uses a hash function to compute an index into an array of buckets or slots, from which the desired value can be found.
/// First, the key is translated into the hash using our hashing function. Then, our hash map performs modulo arithmetic to turn the hash into an array index.

// In the case of a map between two things, we don’t really care about the exact sequence of the data. We only care that a given input, when fed into the map, gives the accurate output. Developing a data structure that performs this is tricky because computers care much more about values than relationships. A computer doesn’t really care to memorize the astrological signs of all of our friends, so we need to trick the computer into caring.

// We perform this trick using a structure that our computer is already familiar with, an array.
// An array uses indices to keep track of values in memory, so we’ll need a way of turning each key in our map to an index in our array.

// Imagine we want our computer to remember that our good friend Joan McNeil is a Libra. We take her name, and we turn that name into a number. Let’s say that the number we correspond with the name “Joan McNeil” is 17. We find the 17th index of the array we’re using to store our map and save the value (Libra) there.

// How did we get 17, though? We use a special function that turns data like the string “Joan McNeil” into a number. This function is called a hashing function, or a hash function. Hashing functions are useful in many domains, but for our data structure the most important aspect is that a hashing function returns an array index as output.

// Hash functions can take various types of input, such as integers, floats, or even custom objects.
// The key requirement is that the hash function must consistently map the input to a valid index in the hash table.

// For example, a hash function for integers could simply return the integer modulo the size of the hash table:

func hashFunction(key: Int, tableSize: Int) -> Int {
    return key % tableSize
}


// A hash function takes a string (or some other type of data) as input and returns an array index as output. In order for it to return an array index, our hash map implementation needs to know the size of our array. If the array we are saving values into only has 4 slots, our hash map’s hashing method should not return an index bigger than that.

// In order for our hash map implementation to guarantee that it returns an index that fits into the underlying array, the hash function will first compute a value using some scoring metric: this is the hash value, hash code, or just the hash. Our hash map implementation then takes that hash value mod the size of the array. This guarantees that the value returned by the hash function can be used as an index into the array we’re using.

// It is actually a defining feature of all hash functions that they greatly reduce any possible inputs (any string you can imagine) into a much smaller range of potential outputs (an integer smaller than the size of our array). For this reason, hash functions are also known as compression functions.

// Much like an image that has been shrunk to a lower resolution, the output of a hash function contains less data than the input. Because of this, hashing is not a reversible process. With just a hash value it is impossible to know for sure the key that was plugged into the hashing function.

/// !!!!!!!!!!!! A hash function must not be reversible because it compresses a large input space into a smaller output space, losing information in the process. This ensures that different inputs can map to the same output, known as collisions. The irreversibility is crucial for security purposes, such as in cryptographic hash functions, where reversing the hash would compromise data integrity.

class HashMap
  
  attr_accessor :buckets
  @@buckets = 0
  @@nodes = 0
  
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  # def self.buckets
  #   @@buckets
  # end

  def set(key, value)
    index = bucket_index(hash(key))
    raise IndexError if index.negative? || index >= @buckets.length
    
    if @buckets[index] == nil
      add_bucket(index).append(key, value)
    end
    change_value(key, value, index)
  end

  def get(key)
    index = bucket_index(hash(key))
    return nil if bucket_empty?(index)
    return nil unless has?(key)

    value(key, index)
  end
  
  def has?(key)
    index = bucket_index(hash(key))
    return false if bucket_empty?(index)

    node = @buckets[index].head
    while node
      return true if node.key == key
      node = node.next_node
    end
    false
  end

  def remove(key)
    index = bucket_index(hash(key))
    return nil if bucket_empty?(index)

    bucket = @buckets[index]
    node = bucket.head
    prev = nil

      if node.key == key
        bucket.head = node.next_node
          return node.value
      end

      while node
        if node.key == key
          prev.next_node = node.next_node
          return node.value
        end
        prev = node
        node = node.next_node
      end
      nil
  end

  def length
    total = 0

    @buckets.each do |bucket|
      next if bucket.nil?
      total += bucket.size
    end
    total
  end

  def clear
    @buckets = Array.new(@capacity)
    @@buckets = 0
    @@nodes = 0
  end

  def keys 
    array = []
    @buckets.each do |bucket|
      next if bucket.nil?

      node = bucket.head
      while node
        array << node.key
        node = node.next_node
      end
    end
    array
  end

  def values
    array = []

    @buckets.each do |bucket|
      next if bucket.nil?

      node = bucket.head
      while node
        array << node.value
        node = node.next_node
      end
    end
    array
  end

  def entries
    array = []
    
    @buckets.each do |bucket|
      next if bucket.nil?

      node = bucket.head
      while node
        pair = []
        pair << node.key
        pair << node.value
        node = node.next_node
        array << pair
      end
    end
    array
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def bucket_index(key)
    index = key % @capacity
    index
  end

  def add_bucket(index)
    @@buckets += 1
    grow_buckets?
    @buckets[index] = Bucket.new(index)
  end

  def change_value(key, value, index)
    if @buckets[index].head == nil && @buckets[index].head.key == key
      @buckets[index].head.value = value
    end
    
    tmp = @buckets[index].head
    while tmp.next_node != nil && tmp.next_node.key != key
      tmp = tmp.next_node
    end
    if tmp.key == key
      tmp.value = value
    else
      @buckets[index].append(key,value)
    end
    grow_buckets?
  end

  def array_length(bucket_array)
    nil_count = 0
    bucket_array.each do |nil_objects|
      if nil_objects.nil?
        nil_count += 1
      end
    end
    length = bucket_array.length - nil_count
  end

  def bucket_empty?(idx)
    @buckets[idx].nil?
  end
  
  def value(key, idx)
    node = @buckets[idx].head
      while node.key != key
        node = node.next_node
      end
      node.value
  end

  def grow_buckets?
    max_load = @capacity * @load_factor
    no_of_entries = length
    if no_of_entries > max_load.floor
      @capacity = @capacity * 2
      key_value_pairs = entries
      clear 
      key_value_pairs.each do |pairs|
        key, value = pairs.first, pairs.last
        set(key, value)          
      end
    end
  end


  class Node
    attr_accessor :key, :value, :next_node
    def initialize( key, value, next_node = nil)
      @key = key
      @value = value
      @next_node = next_node
    end
  end


  class Bucket # this is a linked list for when more than one node is placed in here and must be traversed.
    attr_accessor :head, :index, :append
    
    def initialize(index)
      @index = index
      @head = nil
    end

     # adds a new node containing value to the end of the list.
    def append(key, value)
      if @head == nil
        prepend(key, value)
      else
        tmp = @head
        while tmp.next_node != nil
          tmp = tmp.next_node
        end
        tmp.next_node = Node.new(key, value, nil)
      end
    end

    def prepend(key, value)
      @head = Node.new(key, value, @head)
    end

    def size
      tmp = @head
      if @head == nil
        size_counter = 0
      else
       size_counter = 1
          while tmp.next_node != nil
            size_counter += 1
            tmp = tmp.next_node
          end
      end
      size_counter
    end
  end

end

# hsh = HashMap.new
# p hsh.set("Michael", "Jackson")#1
# p hsh.set("Open", "Claw")#2
# p hsh.set("Michael", "Johnson")#3
# p hsh.set("Peter", "Steinberger")#4
# p hsh.set("Red", "Herring")#5
# p hsh.set("Arthur", "deBono")#6
# p hsh.set("Ariel", "Grande")#7
# p hsh.set("Thomas", "Schumacker")#8
# p hsh.set("Shenia", "Twain")#9
# p hsh.set("Kill", "Bill")#10
# p hsh.set("Renee", "Russo")#11
# p hsh.set("Janet", "Jackson")#12
# p hsh.set("Janet", "Jackso")#13
# # p hsh.set("Missy", "Elliot")#14
# # p hsh.set("Lauren", "Hill")#15
# # p hsh.set("Zaha", "Hadid")#16
# # p hsh.set("Katherine", "Zeta Jones")#17
# p hsh
# p hsh.buckets[7].head.value
# p hsh.buckets[6].size
# p hsh.get("Janet")
# p hsh.get("Zaha")
# p hsh.get("Ronny")

# p hsh.has?("Janet")
# p hsh.has?("Zaha")
# p hsh.has?("Blip")

# p hsh.remove("Ariel")
# p hsh.remove("Twittie")
# p hsh.remove("Janet")

# p hsh.length
# p hsh.clear
# p hsh.keys
# p hsh.values
# p hsh.entries
test = HashMap.new
test.set('apple', 'red')#
test.set('banana', 'yellow')#
test.set('carrot', 'orange')#
test.set('dog', 'brown')
test.set('elephant', 'gray')#
test.set('frog', 'green')#
test.set('grape', 'purple')
test.set('hat', 'black')#
test.set('ice cream', 'white')#
test.set('jacket', 'blue')#
test.set('kite', 'pink')
test.set('lion', 'golden')# this is 12 from TOP
test.set('kite', 'purple')# replaces kite pink
test.set('moon', 'silver')
test.set('Julia', 'Roberts')
test.set('Julietta', 'Dunlop')


p "test.length = #{test.length}"
p test
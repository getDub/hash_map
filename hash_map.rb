class HashMap
  
  attr_accessor :buckets
  @@buckets = 0
  
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    puts "key is: #{key}"
    hash_code
  end


  def bucket_index(key)
    index = key % @capacity
    puts "index is: #{index}"
    index
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # If a key already exist, then the old value is overwritten or we can say update the key's value
  # (e.g. carlos is our key but it is called twice: once with value 'I am the value'., and once with value
  # 'I am the new value.'. From the logic stated above, 'Carlos" should contain only the latter value').
  def set(key, value)
    index = bucket_index(hash(key))
   
    if @buckets[index] == nil
      add_bucket(index).append(key, value)
    end

    change_value(key, value, index)

  end

  private

  def add_bucket(index)
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
    tmp.value = value if tmp.key == key
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

  end

end

hsh = HashMap.new
# p hsh.hash("Michael Jackson")
p hsh.set("Michael", "Jackson")
p hsh.set("Open", "Claw")
p hsh
p hsh.set("Michael", "Johnson")
p hsh.set("Peter", "Steinberger")
p hsh.set("Red", "Herring")
p hsh.set("Arthur", "deBono")
p hsh.set("Ariel", "Grande")
p hsh.set("Thomas", "Schumacker")
p hsh.set("Shenia", "Twain")
p hsh.set("Kill", "Bill")
p hsh.set("Renee", "Russo")
p hsh.set("Janet", "Jackson")
p hsh
p hsh.buckets[7].head.value
# p hsh.bucket_index(hash("Shenia"))
# p hsh.bucket_index(hash("Janet"))


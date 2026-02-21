class HashMap
  
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

    hash_code
  end


  def bucket_index(key)
    index = key % @capacity
    index
  end

  # takes two arguments, the first is a key and the second is a value that is assigned to this key.
  # If a key already exist, then the old value is overwritten or we can say update the key's value
  # (e.g. carlos is our key but it is called twice: once with value 'I am the value'., and once with value
  # 'I am the new value.'. From the logic stated above, 'Carlos" should contain only the latter value').
  def set(key, value)
    index = bucket_index(hash(key))
    @buckets[index] = Bucket.new(index).append(key, value)
  end

  private

  class Node
    attr_accessor :key, :value    
    def initialize( key, value, next_key = nil)
      @key = key
      @value = value
      @next_key = next_key
    end
  end

  class Bucket # this is a linked list for when more than one node is placed in here and must be traversed.
    attr_accessor :head, :index
    
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
p hsh
# p hsh.bucket_index(hsh.hash("Michael"))


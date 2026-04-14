class Node
  attr_accessor :key, :value, :next_node
  def initialize( key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

class HashMap
  
  attr_reader :buckets
  
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  def set(key, value)
    index = bucket_index(hash(key))
    raise IndexError if index.negative? || index >= @buckets.length
    
    add_new_bucket_if_falsy(index)
    
    return value if update_value?(key, value, index)
    
    @buckets[index].append(key, value)
    
    grow_buckets_if_needed
    value
  end
  
  def get(key)
    index = bucket_index(hash(key))
    raise IndexError if index.negative? || index >= @buckets.length

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
    @buckets.sum { |bucket| bucket&.size.to_i }
  end

  def clear
    @buckets = Array.new(@capacity)
  end

  def keys 
    entries.map {|entry| entry.first}
  end

  def values
    entries.map(&:last)
  end

  def entries
    result = []
    @buckets.each do |bucket|
      next if bucket.nil?

      node = bucket.head
      while node
        result << [node.key, node.value]
        node = node.next_node
      end
    end
    result
  end
  
  private
  
  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end
  
  def bucket_index(hash_code)
    index = hash_code % @capacity
    index
  end
    
  def add_new_bucket_if_falsy(at_idx)
    if @buckets[at_idx].nil? || @buckets[at_idx].eql?(false)
      @buckets[at_idx] = Bucket.new(at_idx)
    end
  end

  def update_value?(key, value, index)
    node = @buckets[index].head

    while node
      if node.key.eql?(key)
        node.value = value
        return true
      end
      node = node.next_node
    end
    false
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

  def grow_buckets_if_needed
    return unless length > (@capacity * @load_factor)

    old_entries = entries
    @capacity *= 2
    clear 

    old_entries.each { |key, value| set(key, value) }
  end


  # class Node
  #   attr_accessor :key, :value, :next_node
  #   def initialize( key, value, next_node = nil)
  #     @key = key
  #     @value = value
  #     @next_node = next_node
  #   end
  # end


  # class Bucket # this is a linked list for when more than one node is placed in here and must be traversed.
  #   attr_accessor :head, :index, :append
    
  #   def initialize(index)
  #     @index = index
  #     @head = nil
  #   end

  #    # adds a new node containing value to the end of the list.
  #   def append(key, value)
  #     if @head == nil
  #       prepend(key, value)
  #     else
  #       tmp = @head
  #       while tmp.next_node != nil
  #         tmp = tmp.next_node
  #       end
  #       tmp.next_node = Node.new(key, value, nil)
  #     end
  #   end

  #   def prepend(key, value)
  #     @head = Node.new(key, value, @head)
  #   end

  #   def size
  #     tmp = @head
  #     if @head == nil
  #       size_counter = 0
  #     else
  #      size_counter = 1
  #         while tmp.next_node != nil
  #           size_counter += 1
  #           tmp = tmp.next_node
  #         end
  #     end
  #     size_counter
  #   end
  # end

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
# test = HashMap.new
# test.set('apple', 'red')#1
# test.set('banana', 'yellow')#2
# test.set('carrot', 'orange')#3
# test.set('dog', 'brown')#4
# test.set('elephant', 'gray')#5
# test.set('frog', 'green')#6
# test.set('grape', 'purple')#7
# test.set('hat', 'black')#8
# test.set('ice cream', 'white')#9
# test.set('jacket', 'blue')#10
# test.set('kite', 'pink')#11
# test.set('lion', 'golden')#12 this is 12 from TOP
# test.set('kite', 'purple')#12 replaces kite pink
# test.set('moon', 'silver')#13
# test.set('Julia', 'Roberts')#14
# test.set('Julietta', 'Dunlop')#15
# test.set('Julietta', 'XXXXX')#16 doesn't replace value
# test.set('kite', 'XXXXX')# replaces value
# test.set('moon', 'XXXXX')# replaces value
# test.set('lion', 'XXXXX')# 17 doesn't replace value
# test.set('jacket', 'XXXXX')# replaces value
# test.set('hat', 'XXXXX')# replaces value



# p "test.length = #{test.length}"
# p test

# p test.get('ralph')
# p test.get('Julietta')
# p test.length

# p test.entries
# p test.keys
# p test.values
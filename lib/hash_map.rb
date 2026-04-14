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
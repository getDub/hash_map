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
    return nil unless @buckets[index]

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
    while node
      return node.value if node.key.eql?(key)
      node = node.next_node
    end
    nil
  end

  def grow_buckets_if_needed
    return unless length > (@capacity * @load_factor)

    old_entries = entries
    @capacity *= 2
    clear 
    
    old_entries.each { |key, value| set(key, value) }
  end
end
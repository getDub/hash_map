class HashMap
  
  attr_accessor :buckets
  @@buckets = 0
  
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end



  def set(key, value)
    index = bucket_index(hash(key))
    raise IndexError if index.negative? || index >= @buckets.length

    if @buckets[index] == nil
      add_bucket(index).append(key, value)
    end
    # grow_array?(@buckets)
    change_value(key, value, index)
  end

  def get(key)
    index = bucket_index(hash(key))
    if bucket_empty?(index)
      p nil
    else has?(key)
      puts value(key, index)
    end
  end

  def has?(key)
    index = bucket_index(hash(key))
    if @buckets[index].nil?
      puts false
    else
      node = @buckets[index].head
        while node.key != key
          node = node.next_node
        end
        has = node.key == key
        puts "#{has}"
      end
  end

  private

  # takes a key and produces a hash code with it.
  def hash(key)
    hash_code = 0
    prime_number = 31
    
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    # puts "key is: #{key}"
    hash_code
  end

   def bucket_index(key)
    index = key % @capacity
    # puts "index is: #{index}"
    index
  end

  def add_bucket(index)
    @@buckets += 1
    puts "no. of buckets = #{@@buckets}"
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
    # tmp.value = value if tmp.key == key
    if tmp.key == key
      tmp.value = value
    else
      @buckets[index].append(key,value)
    end
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
      # puts "node val in val is #{node.value}"
      node.value
  end
  # def grow_array?(total_buckets)
  #   growth_number = @capacity * @load_factor
  #   puts "growth number = #{growth_number.floor}"
  #   if array_length(total_buckets) >= growth_number.floor
  #     @capacity = @capacity * 2
  #     puts "new capacity = #{@capacity} and buckets are now = #{@buckets.length}"
  #     # new_array = Array.new(@capacity)
  #     # array_copy = @buckets
  #     # @buckets = Array.new(@capacity)
  #     @buckets.each do |element|
  #       if element.size > 1
  #         tmp = element.head
  #         while tmp.next_node != nil
  #           tmp = tmp.next_node
  #           self.set(tmp.key, tmp.value)
  #         end
  #       puts "element = #{element.head.key}" if element != nil
  #     end        
  #   end
  # end

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

hsh = HashMap.new
# p hsh.hash("Michael Jackson")
p hsh.set("Michael", "Jackson")
p hsh.set("Open", "Claw")
p hsh
p hsh.set("Michael", "Johnson")
# p hsh.set("Peter", "Steinberger")
p hsh.set("Red", "Herring")
p hsh.set("Arthur", "deBono")
p hsh.set("Ariel", "Grande")
p hsh.set("Thomas", "Schumacker")
p hsh.set("Shenia", "Twain")
p hsh.set("Kill", "Bill")
p hsh.set("Renee", "Russo")
p hsh.set("Janet", "Jackson")
p hsh.set("Janet", "Jackso")
p hsh.set("Missy", "Elliot")
p hsh.set("Lauren", "Hill")
p hsh.set("Zaha", "Hadid")
p hsh.set("Katherine", "Zeta Jones")
p hsh
# p hsh.buckets[7].head.value
# p hsh.buckets[6].size
hsh.get("Janet")
hsh.get("Zaha")
hsh.get("Ronny")

hsh.has?("Janet")
hsh.has?("Zaha")
hsh.has?("Ronny")
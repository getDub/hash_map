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
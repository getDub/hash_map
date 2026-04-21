class HashSet < HashMap
  
  def set(key, value = nil)
    super
    key
  end

  def get(key)
    key
  end
 
  def keys
    super()
  end

  def entries
    super
  end

  def values
    []
  end
end
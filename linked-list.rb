class Node
  attr_accessor :value,:next_node

  def initialize value=nil,nextNode=nil
    @value = value
    @next_node = nextNode
  end

  def to_s
    "( #{value} )"
  end

  def tail?
    @next_node.nil?
  end

end

class LinkedList
  attr_accessor :head

  def initialize head=nil
    @head = head
  end

  def empty?
    return @head.nil?
  end

  def append newNode
    if empty?
      @head = newNode
      return true
    end

    node = @head

    until node.tail?
      node = node.next_node
    end

    node.next_node = newNode
    return true
  end

  def prepend newNode
    if empty?
      @head = newNode
      return true
    end

    newNode.next_node = @head
    @head = newNode
    return true
  end

  def size
    return 0 if empty?

    node = @head
    listSize = 1
    until node.tail?
      listSize += 1
      node = node.next_node
    end
    return listSize
  end

  def tail
    return nil if empty?

    node = @head
    until node.tail?
      node = node.next_node
    end
    return node
  end

  def at index
    return nil if empty?

    node = @head
    index.times{
      if node.tail?
        return nil
      else
        node = node.next_node
      end
    }
    return node
  end

  def pop
    return nil if empty?

    node = @head

    if node.tail?
      @head = nil
      return @head #don't remove anything in this case, because there is only one element
    end

    until node.next_node.tail?
      node = node.next_node
    end

    tail = node.next_node
    node.next_node = nil

    return tail
  end

  def contains? value
    return false if empty?

    node = @head
    return true if value == node.value

    until node.tail?
      node = node.next_node
      return true if value == node.value
    end

    return false
  end

  def find value
    return nil if empty?

    node = @head
    return 0 if value == node.value

    index = 0
    until node.tail?
      node = node.next_node
      index += 1
      return index if value == node.value
    end

    return nil
  end

  def to_s
    return "( nil )" if @head.nil?

    node = head
    str = node_str(node)
    until node.next_node.nil?
      node = node.next_node
      str += node_str(node)
    end
    str += "nil"
    return str
  end

  def insert_at index,nodeToInsert
    #insert nodeToInsert at index.  Find index-1, then point next_node to this node.
    #Then
    return prepend nodeToInsert if index == 0
    return append nodeToInsert if index == size
    return false if index > size || index < 0

    node = at(index-1)

    nodeAfterInsertion = node.next_node
    node.next_node = nodeToInsert
    nodeToInsert.next_node = nodeAfterInsertion

    return true
  end

  def remove_at index
    return false if index >= size || index < 0

    if index == 0
      nodeToRemove = @head
      @head = @head.next_node
      return nodeToRemove
    end

    node = at(index-1)
    return false if node.nil?

    nodeToRemove = node.next_node
    nodeAfterRemoval = nodeToRemove.next_node
    node.next_node = nodeAfterRemoval

    return nodeToRemove
  end
  private

  def node_str node
    return "( #{node.nil? ? "nil" : node.value} ) -> "
  end
end
class StructNode
    def initialize(name, keys = [], childs = [])
      @name = name
      @keys = keys
      @childs = childs
   end
   
   attr_reader :keys
   attr_reader :name
   attr_reader :childs
   attr_writer :childs
   attr_writer :keys
end

def valueIsGroup(value)
   value.match("^.+\/.+$") != nil
end

def getFirstGroup(value)
    value.slice(0..(value.index('/') -1)).to_s
end

def dropFirstGroup(value)
    value.match("^*\/.+$").to_s[1..-1]
end

def insertKey(node, value)
    if valueIsGroup(value)
        name = getFirstGroup(value)
        nextValue = dropFirstGroup(value)
        child = node.childs.find { |child| child.name == name }
        if child.nil?
            child = StructNode.new(name)
            node.childs.push(child)
            insertKey(child, nextValue)
        else
           insertKey(child, nextValue)
        end
    else
        node.keys.push(value)
    end
end

def printNode(node, count)
    prefix = ""
    count.times { prefix += " " }
    puts "#{prefix} Name: #{node.name}"
    puts "#{prefix} Keys: #{node.keys}"
    puts "#{prefix} Childs:"
    node.childs.each { |child| printNode(child, count + 1) }
end


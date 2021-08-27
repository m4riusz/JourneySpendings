#!/usr/bin/ruby

class StructNode
   def initialize(name, keys = [], childs = [])
      @name = name
      @keys = keys
      @childs = childs
   end
   
   attr_reader :keys
   attr_reader :name
   attr_reader :childs
   
   def insertKey(node = self, value)
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

   private

   def valueIsGroup(value)
      value.match("^.+\/.+$") != nil
   end
   
   def getFirstGroup(value)
       value.slice(0..(value.index('/') -1)).to_s
   end
   
   def dropFirstGroup(value)
       value.match("^*\/.+$").to_s[1..-1]
   end
end

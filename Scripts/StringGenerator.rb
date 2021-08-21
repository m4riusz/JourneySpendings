#!/usr/bin/ruby

moduleName = $0
inputStringsFie = $1
outputSwiftFile = $2

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

def readKeysFromFile(filePath)
   file = File.open(filePath, "r")
   rawKeys = []
   lines = file.readlines.map(&:chomp)
   lines.each { |line| rawKeys.push(line.split("=").first.chomp.delete("\"")) }
   file.close
   return rawKeys
end

def generateStructs(file, moduleName, node, depth)
    prefix = ""
    depth.times { prefix += "\t" }
    file << "#{prefix}public struct #{node.name} {\n"
    node.keys.each { |key| file << "#{prefix}\tstatic let #{key} = String.localized(\"#{moduleName}\", \"key\")\n" }
    node.childs.each { |child| generateStructs(file, moduleName, child, depth + 1) }
    file << "#{prefix}}\n"
end

def generateExtension(outputFile,moduleName, node)
   file = File.open(outputFile, "w")
   file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
   file << "public extension Assets.Strings {\n"
   generateStructs(file, moduleName,  node, 1)
   file << "}\n"
   file.close
end

keys = readKeysFromFile(inputStringsFile)
root = StructNode.new(moduleName)
keys.each { |key| insertKey(root, key) }
generateExtension(outputSwiftFile, moduleName, root) 

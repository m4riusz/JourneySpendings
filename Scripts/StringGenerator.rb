#!/usr/bin/ruby

require "./StructNode.rb"
require "./FileUtils.rb"

include FileUtils

moduleName = ARGV[0]
inputStringsFile = ARGV[1]
outputSwiftFile = ARGV[2]

keys = FileUtils::readKeysFromFile(inputStringsFile)
root = StructNode.new(moduleName)
keys.each { |key| root.insertKey(key) }
FileUtils::generateExtension(outputSwiftFile, moduleName, root) 

#!/usr/bin/ruby

require_relative "StructNode.rb"
require_relative "FileUtils.rb"

include FileUtils

moduleName = ARGV[0]
inputStringsFile = ARGV[1]
outputSwiftFile = ARGV[2]

keys = FileUtils::readKeysFromStringsFile(inputStringsFile)
root = StructNode.new(moduleName)
keys.each { |key| root.insertKey(key) }
FileUtils::generateStringExtension(outputSwiftFile, moduleName ,root)
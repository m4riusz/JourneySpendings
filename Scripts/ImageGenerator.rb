#!/usr/bin/ruby

require "./StructNode.rb"
require "./FileUtils.rb"

include FileUtils

moduleName = ARGV[0]
imageAssetsPath = ARGV[1]
outputSwiftFile = ARGV[2]

keys = FileUtils::readKeysFromImageAssetsCatalog(imageAssetsPath)

root = StructNode.new(moduleName)
keys.each { |key| root.insertKey(key) }
FileUtils::generateImageExtension(outputSwiftFile, moduleName ,root) 
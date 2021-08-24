#!/usr/bin/ruby

imageAssetsPath = ARGV[0]

imageFiles = Dir["#{imageAssetsPath}/**/*"]
   .filter { |file| file.match("^*\\.(imageset|appiconset)$") }
   .map { |name| name.sub(/.*Assets.xcassets\//, "") }

puts imageFiles
#!/usr/bin/ruby

stringsFilePath = "args"
outputPath = "output"
moduleName = "Journey"
keyValue = "\"Hello\" = \"SomeWalue\";"

def stringsLineToLocalization(line, moduleName) 
    key = line.split("=")[0]["\"".length..-"\\\" ".length]
    return "static let #{key} = String.localized(#{moduleName},\"#{key}\")"
end

def generateSwiftExtension(moduleName, keys)
	text = """//Auto generated. Do not modify manually
extension Assets.Strings {
    struct #{moduleName} {
        #{stringsLineToLocalization(keys, moduleName)}
    }
}
"""
	return text
end

puts "----------------------------"
puts "Generating localized strings" 
puts "Module: #{moduleName}"
puts "Source: #{stringsFilePath}"
puts "Output: #{outputPath}"
puts "----------------------------"

puts generateSwiftExtension(moduleName, keyValue)

#!/usr/bin/ruby

module FileUtils
    def readKeysFromFile(filePath)
        file = File.open(filePath, "r")
        rawKeys = []
        lines = file.readlines.map(&:chomp)
        lines.each { |line| rawKeys.push(line.split("=").first.chomp.delete("\"")) }
        file.close
        return rawKeys
    end
    
    def generateExtension(outputFile, moduleName, node)
       file = File.open(outputFile, "w")
       file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
       file << "public extension Assets.Strings {\n"
       generateStructs(file, moduleName,  node, 1)
       file << "}\n"
       file.close
    end

    def generateStructs(file, moduleName, node, depth)
        prefix = ""
        depth.times { prefix += "\t" }
        file << "#{prefix}public struct #{node.name} {\n"
        node.keys.each { |key| file << "#{prefix}\tstatic let #{key} = String.localized(\"#{moduleName}\", \"key\")\n" }
        node.childs.each { |child| generateStructs(file, moduleName, child, depth + 1) }
        file << "#{prefix}}\n"
    end
end
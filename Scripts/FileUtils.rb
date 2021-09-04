#!/usr/bin/ruby

module FileUtils
    def readKeysFromStringsFile(filePath)
        file = File.open(filePath, "r")
        rawKeys = []
        lines = file.readlines.map(&:chomp)
        lines.each { |line| 
            key = line.split("=").first
            unless key.nil?
                rawKeys.push(key.chomp.delete("\"").strip) 
            end
        }
        file.close
        return rawKeys
    end

    def readKeysFromImageAssetsCatalog(filePath)
        Dir["#{filePath}/**/*"]
          .filter { |file| file.match("^*\\.(imageset|appiconset)$") }
          .map { |name| name.sub(/.*Assets.xcassets\//, "") }
          .map { |name| name.sub(/\.\w*/, "") }
    end
    
    def generateStringExtension(outputFile, moduleName, node, importCore = true)
       file = File.open(outputFile, "w")
       file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
       if importCore
           file << "import Core\n\n"
       end
       file << "public extension Assets.Strings {\n"
       generateStringStructs(file, moduleName,  node, 1)
       file << "}\n"
       file.close
    end

    def generateStringStructs(file, moduleName, node, depth)
        prefix = ""
        depth.times { prefix += "\t" }
        file << "#{prefix}struct #{node.name} {\n"
        node.keys.each { |key| file << "#{prefix}\tstatic let #{key} = String.localized(\"#{moduleName}\", \"#{key}\")\n" }
        node.childs.each { |child| generateStringStructs(file, moduleName, child, depth + 1) }
        file << "#{prefix}}\n"
    end

    def generateImageExtension(outputFile, moduleName, node, importCore = true)
        file = File.open(outputFile, "w")
        file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
        if importCore
            file << "import Core\n\n"
        end
        file << "import UIKit\n\n"
        file << "public extension Assets.Images {\n"
        generateImageStructs(file, moduleName,  node, 1, "")
        file << "}\n"
        file.close
     end
 
     def generateImageStructs(file, moduleName, node, depth, fullPath)
         prefix = ""
         depth.times { prefix += "\t" }
         if depth > 1
            fullPath += "#{node.name}/"
         end
         file << "#{prefix}struct #{node.name} {\n"
         node.keys.each { |key| file << "#{prefix}\tstatic let #{key} = UIImage(named: \"#{fullPath}#{key}\")\n" }
         node.childs.each { |child| generateImageStructs(file, moduleName, child, depth + 1, fullPath) }
         file << "#{prefix}}\n"
     end
end
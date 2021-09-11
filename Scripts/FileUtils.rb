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
          .map { |name| name.sub(/.*Images.xcassets\//, "") }
          .map { |name| name.sub(/\.\w*/, "") }
    end

    def readKeysFromColorAssetsCatalog(filePath)
        Dir["#{filePath}/**/*"]
          .filter { |file| file.match("^*\\.(colorset)$") }
          .map { |name| name.sub(/.*Colors.xcassets\//, "") }
          .map { |name| name.sub(/\.\w*/, "") }
    end
    
    def generateStringExtension(outputFile, moduleName, node, importCore = true)
       file = File.open(outputFile, "w")
       file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
       if importCore
           file << "import Core\n"
       end
       file << "import UIKit\n\n"
       file << "public extension Assets.Strings {\n"
       file << "\tprivate class BundleClass { /*Nop*/ }\n"
       file << "\tprivate static let bundle = Bundle(for: BundleClass.self)\n"
       generateStringStructs(file, moduleName,  node, 1)
       file << "}\n"
       file.close
    end

    def generateStringStructs(file, moduleName, node, depth)
        prefix = ""
        depth.times { prefix += "\t" }
        file << "#{prefix}public struct #{node.name} {\n"
        node.keys.each { |key| file << "#{prefix}\tpublic static let #{key} = String.localized(\"#{moduleName}\", \"#{key}\", bundle)\n" }
        node.childs.each { |child| generateStringStructs(file, moduleName, child, depth + 1) }
        file << "#{prefix}}\n"
    end

    def generateImageExtension(outputFile, moduleName, node, importCore = true)
        file = File.open(outputFile, "w")
        file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
        if importCore
            file << "import Core\n"
        end
        file << "import UIKit\n\n"
        file << "public extension Assets.Images {\n"
        file << "\tprivate class BundleClass { /*Nop*/ }\n"
        file << "\tprivate static let bundle = Bundle(for: BundleClass.self)\n"
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
         file << "#{prefix}public struct #{node.name} {\n"
         node.keys.each { |key| file << "#{prefix}\tpublic static let #{key} = UIImage(\"#{fullPath}#{key}\", bundle)\n" }
         node.childs.each { |child| generateImageStructs(file, moduleName, child, depth + 1, fullPath) }
         file << "#{prefix}}\n"
     end

     def generateColorExtension(outputFile, moduleName, node, importCore = true)
        file = File.open(outputFile, "w")
        file << "/*\nAuto generated\nDo not modify manually!\n*/\n"
        if importCore
            file << "import Core\n"
        end
        file << "import UIKit\n\n"
        file << "public extension Assets.Colors {\n"
        file << "\tprivate class BundleClass { /*Nop*/ }\n"
        file << "\tprivate static let bundle = Bundle(for: BundleClass.self)\n"
        generateColorStructs(file, moduleName,  node, 1, "")
        file << "}\n"
        file.close
     end

     def generateColorStructs(file, moduleName, node, depth, fullPath)
        prefix = ""
        depth.times { prefix += "\t" }
        if depth > 1
           fullPath += "#{node.name}/"
        end
        file << "#{prefix}public struct #{node.name} {\n"
        node.keys.each { |key| file << "#{prefix}\tpublic static let #{key} = UIColor(\"#{fullPath}#{key}\", bundle)\n" }
        node.childs.each { |child| generateColorStructs(file, moduleName, child, depth + 1, fullPath) }
        file << "#{prefix}}\n"
    end
end
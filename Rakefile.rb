
namespace :project do
    desc "Generate project"
    task :generate => [:generateAssetsFiles] do
        puts "Generating project file"
        sh "rm -rf JourneySpendings.xcodeproj/"
        sh "xcodegen generate --spec project.json"
    end

    desc "Generate assets files"
    task :generateAssetsFiles do
        puts "Generate assets files for About"
        sh "mkdir -p About/Resources/Generated/"
        sh "touch About/Resources/Generated/AboutStrings.swift"
        sh "touch About/Resources/Generated/AboutImages.swift"
        sh "./Scripts/StringGenerator.rb About About/Resources/en.lproj/About.strings About/Resources/Generated/AboutStrings.swift"
        sh "./Scripts/ImageGenerator.rb About About/Resources/Assets.xcassets About/Resources/Generated/AboutImages.swift"

        puts "Generate assets files for Core"
        sh "mkdir -p Core/Resources/Generated/"
        sh "touch Core/Resources/Generated/CoreStrings.swift"
        sh "touch Core/Resources/Generated/CoreImages.swift"
        sh "./Scripts/StringGenerator.rb Core Core/Resources/en.lproj/Core.strings Core/Resources/Generated/CoreStrings.swift"
        sh "./Scripts/ImageGenerator.rb Core Core/Resources/Assets.xcassets Core/Resources/Generated/CoreImages.swift"

        puts "Generate assets files for Journey"
        sh "mkdir -p Journey/Resources/Generated/"
        sh "touch Journey/Resources/Generated/JourneyStrings.swift"
        sh "touch Journey/Resources/Generated/JourneyImages.swift"
        sh "./Scripts/StringGenerator.rb Journey Journey/Resources/en.lproj/Journey.strings Journey/Resources/Generated/JourneyStrings.swift"
        sh "./Scripts/ImageGenerator.rb Journey Journey/Resources/Assets.xcassets Journey/Resources/Generated/JourneyImages.swift"

        puts "Generate assets files for MobileApp"
        sh "mkdir -p MobileApp/Resources/Generated/"
        sh "touch MobileApp/Resources/Generated/MobileAppStrings.swift"
        sh "touch MobileApp/Resources/Generated/MobileAppImages.swift"
        sh "./Scripts/StringGenerator.rb MobileApp MobileApp/Resources/en.lproj/MobileApp.strings MobileApp/Resources/Generated/MobileAppStrings.swift"
        sh "./Scripts/ImageGenerator.rb MobileApp MobileApp/Resources/Assets.xcassets MobileApp/Resources/Generated/MobileAppImages.swift"
    end
end
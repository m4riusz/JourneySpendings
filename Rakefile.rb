
namespace :project do
    desc "Generate project"
    task :generate => [:assets] do
        puts "Generating project file"
        sh "rm -rf JourneySpendings.xcodeproj/"
        sh "xcodegen generate --spec project.json"
    end

    desc "Generate assets files"
    task :assets do
        puts "Generate assets files for About"
        sh "mkdir -p About/Resources/Generated/"
        sh "touch About/Resources/Generated/AboutStrings.swift"
        sh "touch About/Resources/Generated/AboutImages.swift"
        sh "./Scripts/StringGenerator.rb About About/Resources/en.lproj/About.strings About/Resources/Generated/AboutStrings.swift"
        sh "./Scripts/ImageGenerator.rb About About/Resources/Images.xcassets About/Resources/Generated/AboutImages.swift"
        sh "./Scripts/ColorGenerator.rb About About/Resources/Colors.xcassets About/Resources/Generated/AboutColors.swift"

        puts "Generate assets files for Core"
        sh "mkdir -p Core/Resources/Generated/"
        sh "touch Core/Resources/Generated/CoreStrings.swift"
        sh "touch Core/Resources/Generated/CoreImages.swift"
        sh "./Scripts/StringGenerator.rb Core Core/Resources/en.lproj/Core.strings Core/Resources/Generated/CoreStrings.swift false"
        sh "./Scripts/ImageGenerator.rb Core Core/Resources/Images.xcassets Core/Resources/Generated/CoreImages.swift false"
        sh "./Scripts/ColorGenerator.rb Core Core/Resources/Colors.xcassets Core/Resources/Generated/CoreColors.swift false"

        puts "Generate assets files for Journey"
        sh "mkdir -p Journey/Resources/Generated/"
        sh "touch Journey/Resources/Generated/JourneyStrings.swift"
        sh "touch Journey/Resources/Generated/JourneyImages.swift"
        sh "./Scripts/StringGenerator.rb Journey Journey/Resources/en.lproj/Journey.strings Journey/Resources/Generated/JourneyStrings.swift"
        sh "./Scripts/ImageGenerator.rb Journey Journey/Resources/Images.xcassets Journey/Resources/Generated/JourneyImages.swift"
        sh "./Scripts/ColorGenerator.rb Journey Journey/Resources/Colors.xcassets Journey/Resources/Generated/JourneyColors.swift"

        puts "Generate assets files for MobileApp"
        sh "mkdir -p MobileApp/Resources/Generated/"
        sh "touch MobileApp/Resources/Generated/MobileAppStrings.swift"
        sh "touch MobileApp/Resources/Generated/MobileAppImages.swift"
        sh "./Scripts/StringGenerator.rb MobileApp MobileApp/Resources/en.lproj/MobileApp.strings MobileApp/Resources/Generated/MobileAppStrings.swift"
        sh "./Scripts/ImageGenerator.rb MobileApp MobileApp/Resources/Images.xcassets MobileApp/Resources/Generated/MobileAppImages.swift"
        sh "./Scripts/ColorGenerator.rb MobileApp MobileApp/Resources/Colors.xcassets MobileApp/Resources/Generated/MobileAppColors.swift"
    end
end
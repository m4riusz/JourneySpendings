
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

        puts "Generate assets files for Core"
        sh "mkdir -p Core/Resources/Generated/"
        sh "touch Core/Resources/Generated/CoreStrings.swift"
        sh "touch Core/Resources/Generated/CoreImages.swift"

        puts "Generate assets files for Journey"
        sh "mkdir -p Journey/Resources/Generated/"
        sh "touch Journey/Resources/Generated/JourneyStrings.swift"
        sh "touch Journey/Resources/Generated/JourneyImages.swift"

        puts "Generate assets files for MobileApp"
        sh "mkdir -p MobileApp/Resources/Generated/"
        sh "touch MobileApp/Resources/Generated/MobileAppStrings.swift"
        sh "touch MobileApp/Resources/Generated/MobileAppImages.swift"
    end
end
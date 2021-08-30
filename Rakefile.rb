
namespace :project do
    desc "Generate project"
    task :generate do
        puts "Generating project file"
        sh "mkdir -p JourneySpendings/Resources/Generated/"
        sh "touch JourneySpendings/Resources/Generated/JourneyStrings.swift"
        sh "touch JourneySpendings/Resources/Generated/JourneyImages.swift"
        sh "rm -rf MobileApp.xcodeproj/"
        sh "xcodegen generate --spec project.json"
    end
end
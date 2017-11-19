require_relative "Tag"

module CvCreator
    class Runner
        def initialize(argumentList,viewClass)
            @maxArgumentsCount = 1000;
            @fileExtension = ".tex"
            @headerFile = "header"
            @typicalAvailableLanguages = ["En", "Fr"]
            @typicalAvailableClasses = ["research", "computerScience", "teaching", "other"]

            parseArguments(argumentList)
            @viewClass = viewClass
        end
        def run
            printUsageAndExit if !areArgumentsValid()
            headerTags = Tag::parse(fileContentToString(filePath(@headerFile)))
            dataHash = Hash[sectionNames().collect { |name| [name, fileContentToString(filePath(name))] }]
            puts @viewClass.new(headerTags,dataHash,@options).content
        end

        def areArgumentsValid()
            @dataDirectory != nil and @typicalAvailableLanguages.include?(@options[:language])
        end
        def fileName(name)
            name + @fileExtension
        end
        def filePath(name)
            @dataDirectory + fileName(name)
        end
        def sectionNames
            @viewClass.sectionToClass().keys
        end

        attr_reader :dataDirectory
        attr_reader :options

    private
        def fileContentToString(filePath)
            if File.readable?(filePath) then File.new(filePath).read else "" end
        end
        def parseArguments(argumentList)
            @dataDirectory = argumentList[0] + "/" if argumentList.size > 0
            @options={language: "", classes: []}
            @options[:language] = argumentList[1] if argumentList.size > 1
            @options[:classes] += argumentList[2..@maxArgumentsCount] if argumentList.size > 2
        end
        def printUsageAndExit
            puts "Usage: bin/CvCreator pathToDataDirectory language [class ...]"
            puts "\nData directory will be searched for the files:\n#{fileName(@headerFile)}"
            puts sectionNames.map { |name| fileName(name) }
            puts "\nTypical available languages:"
            puts @typicalAvailableLanguages
            puts "\nTypical available classes:"
            puts @typicalAvailableClasses
            exit
        end
    end # Runner
end # CvCreator

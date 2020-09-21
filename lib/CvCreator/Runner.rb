require_relative "Tag"

require_relative "HtmlView"
require_relative "TexView"

module CvCreator
    class Runner
        def initialize(argumentList)
            @maxArgumentsCount = 1000;
            @fileExtension = ".tex"
            @headerFile = "header"
            @typicalAvailableLanguages = ["En", "Fr"]
            @typicalAvailableClasses = ["research", "computerScience", "teaching", "other"]
            @nameToViewClass = {
                "HtmlView" => CvCreator::HtmlView,
                "TexView" => CvCreator::TexView,
            }

            parseArguments(argumentList)
        end
        def run
            printUsageAndExit if !areArgumentsValid()
            headerTags = Tag::parse(fileContentToString(filePath(@headerFile)))
            dataHash = Hash[sectionNames().collect { |name| [name, fileContentToString(filePath(name))] }]
            @viewClass.new(headerTags,dataHash,@options).content
        end

        def areArgumentsValid()
            @dataDirectory != nil \
                and @viewClass != nil
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
        def viewClassesNames
            @nameToViewClass.keys
        end

        attr_accessor :viewClass
        attr_reader :dataDirectory
        attr_reader :options

    private
        def fileContentToString(filePath)
            if File.readable?(filePath) then File.new(filePath).read else "" end
        end
        def parseArguments(argumentList)
            @viewClass = @nameToViewClass[argumentList[0]] if argumentList.size > 0
            @dataDirectory = argumentList[1] + "/" if argumentList.size > 1
            @options={language: "", classes: []}
            @options[:language] = argumentList[2] if argumentList.size > 2
            @options[:classes] += argumentList[3..@maxArgumentsCount] if argumentList.size > 3
        end
        def printUsageAndExit
            puts "Usage: bin/CvCreator viewClassName pathToDataDirectory language [class ...]"
            puts "\nThe available view classes are:\n"
            puts viewClassesNames()
            if @viewClass.nil? then exit end
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

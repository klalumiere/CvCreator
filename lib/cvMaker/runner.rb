module CvMaker
	class Runner
		def initialize(viewClass,argumentList)
			@sectionNames=[
				"skillSummary",
				"education",
				"experience",
				"autodidactTraining",
				"honor",
				"socialImplication",
				"publication",
				"talk"
			]
			@suffixFileName=".tex"

			@viewClass=viewClass
			parseArguments(argumentList)
		end
		def run
			dataHash={}
			@sectionNames.each { |name|
				data=""
				@dataDirectory+="/" if @dataDirectory[-1] != "/"
				filePath=@dataDirectory+name+@suffixFileName
				data=File.new(filePath).read if File.readable?(filePath)
				dataHash[name.intern]=data
			}

			@viewClass.new(dataHash,@options).content
		end

	private
		def parseArguments(argumentList)
			outOfBoundLength=argumentList.length < 2 or argumentList.length > 1000
			if outOfBoundLength
				printUsage
				exit
			end

			@dataDirectory=argumentList[0]
			@options={language: "", classes: []}
			
			@options[:language]=argumentList[1] if argumentList.size > 1
			checkLanguage(@options[:language])
			@options[:classes]+=argumentList[2..argumentList.size-1] if argumentList.size > 2
		end
		def printUsage
			puts "Usage: cvMaker pathToDataDirectory language [class ...]\n"
			puts "Data directory will be searched for the files:"
			@sectionNames.each {|name| puts name+@suffixFileName }
		end
		def checkLanguage(language)
			availableLanguage=["Fr", "En"]
			if !availableLanguage.include?(language)
				puts "Available language:"
				puts availableLanguage
				exit
			end
		end
	end
end
require_relative "section"
require_relative "headers"

module CvMaker
	class Runner
		def initialize(argumentList)
			@sectionClasses={
				skillSummary: CvMaker::SkillSummary,
				education: CvMaker::Education,
				experience: CvMaker::Experience,
				autodidactTraining: CvMaker::AutodidactTraining,
				honor: CvMaker::Honor,
				socialImplication: CvMaker::SocialImplication,
				publication: CvMaker::Publication,
				talk: CvMaker::Talk
			}
			@suffixFileName=".tex"

			parseArguments(argumentList)
		end
		def run
			result=CvMaker::header()
			@sectionClasses.each { |key,tagClass|
				data=""
				filePath=@directory+key.to_s+@suffixFileName
				data= File.new(filePath).read if File.readable?(filePath)
				newTex=tagClass.new(data,@options).tex
				result+=newTex+"\n\n\n" if newTex != ""
			}
			result+=CvMaker::footer()
			result
		end

	private
		def parseArguments(argumentList)
			outOfBoundLength=argumentList.length < 2 or argumentList.length > 1000
			if outOfBoundLength
				printUsage
				exit
			end

			@directory=argumentList[0]
			@options={language: "", classes: []}
			@options[:language]=argumentList[1] if argumentList.size > 1
			@options[:classes]+=argumentList[2..argumentList.size-1] if argumentList.size > 2
		end
		def printUsage
			puts "Usage: cvMaker pathToDataDirectory language [class ...]\n"
			puts "Data directory will be searched for the files:"
			@sectionClasses.each_key {|key| puts key.to_s+@suffixFileName }
		end
	end
end
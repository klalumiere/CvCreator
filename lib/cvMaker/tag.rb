module CvMaker
	class TooManyTags < RuntimeError
	end

	class Tag
		def initialize(name,content)
			@name=name
			@content=content
			@subTagsAreCached=false
		end
		attr_reader :name, :content

		def self.parseTag(text)
			tagList = []
			until text.empty?
				matched=Tag.tagPattern.match(text)
				if !matched.nil?
					text=matched.post_match
					tagList.push(Tag.new(matched[:name],matched[:content]))
				else
					text=""
				end
			end
			tagList
		end

		def subTags
			if !@subTagsAreCached
				@subTagsCached=Tag.parseTag(content)
				@subTagsAreCached=true
			end
			@subTagsCached
		end

	private
		def self.tagPattern
			/ \\(?<name> \w+) {
				(?<content>
					(
						[^{}] | 
						(?<innerBraket> 
							{ ([^{}] | \g<innerBraket>)* }
						)
					)* 
				)
			}
			/x
		end
	end

	def CvMaker.findTagsByName(subTagList,tagName)
		found=[]
		subTagList.each { |elem|
			if elem.name==tagName
				found.push(elem)
			end
		}
		found
	end

	def CvMaker.contentByName(subTagList,tagName)
		content=""
		foundNumber=0
		subTagList.each { |elem|
			if elem.name==tagName
				content=elem.content
				foundNumber=foundNumber.next
				raise TooManyTags if foundNumber > 1
			end
		}
		content
	end

	def CvMaker.contentsByName(subTagList,tagName)
		content=[]
		subTagList.each { |elem|
			if elem.name==tagName
				content=content+[elem.content]
			end
		}
		content
	end
end
module CvCreator

    class Tag
        def initialize(name,content, recursionDepth = 0)
            if recursionDepth >= Tag.getMaxRecursionDepth()
                raise "Max recursion depth " + Tag.getMaxRecursionDepth().to_s() + " reached."
            end

            @name = name
            @content = content
            @subtags = Tag.parseSubtags(content,recursionDepth)
        end

        def self.parse(text)
            parseSubtags(text,0)
        end

        def self.getMaxRecursionDepth()
            100
        end

        attr_reader :name, :content, :subtags

    private
        def self.parseSubtags(content,recursionDepth)
            toTag = lambda { |name,content,innerBraket| Tag.new(name,content,recursionDepth+1) }
            content.scan(Tag.subtagPattern()).map(&toTag)
        end

        def self.subtagPattern
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
    end # Tag



    def CvCreator.findTagsByName(tagList, name)
        tagList.select { |tag| tag.name() == name }
    end

    def CvCreator.findTagsContentByName(tagList, name)
        findTagsByName(tagList, name).map { |tag| tag.content() }
    end

    def CvCreator.findTagContentByName(tagList, name)
        result = findTagsContentByName(tagList, name)
        raise "This function expects at most a single match in the tag list." if result.size > 1
        result.reduce("") { |seed,x| seed + x }
    end

end # CvCreator

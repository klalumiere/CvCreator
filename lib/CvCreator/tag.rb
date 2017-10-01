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
        def self.parseSubtags(text,recursionDepth)
            tagList = []
            until text.empty?
                matched = Tag.subtagPattern.match(text)
                if !matched.nil?
                    text=matched.post_match
                    tagList.push(Tag.new(matched[:name],matched[:content],recursionDepth+1))
                else
                    text=""
                end
            end
            tagList
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
        resultInList = findTagsByName(tagList, name).map { |tag| tag.content() }
        raise "This function expects a single match in the tag list." if resultInList.length() > 1
        if resultInList.length() == 1 then resultInList[0] else "" end
    end

end # CvCreator

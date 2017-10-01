require "test/unit"

module CvCreator

    class TestTag < Test::Unit::TestCase
        def setup
            @arbitraryName = "name"
        end

        def testCreate
            assertEqTag(@arbitraryName, "content", Tag.new(@arbitraryName,"content"))
        end
        def testWithNoSubtag
            tag = createTagWithContent("content")
            assert_empty(tag.subtags())
        end
        def testWithOneSubtag
            tag = createTagWithContent("\\name0{content0}")
            assert_equal(1,tag.subtags().length())
            assertEqTag("name0","content0",tag.subtags()[0])
        end
        def testWithManySubtags
            tag = createTagWithContent("\\name0{content0}\\name1{content1}")
            assert_equal(2,tag.subtags().length())
            assertEqTag("name0","content0",tag.subtags()[0])
            assertEqTag("name1","content1",tag.subtags()[1])
        end
        def testWithNestedSubtags
            tag = createTagWithContent("\\name0{\\nestedName{nestedContent}}")
            assert_equal(1,tag.subtags().length())
            assertEqTag("name0","\\nestedName{nestedContent}",tag.subtags()[0])
            assert_equal(1,tag.subtags()[0].subtags().length())
            assertEqTag("nestedName", "nestedContent", tag.subtags()[0].subtags()[0])
        end
        def testMaxRecursionDepth
            assert_raise { Tag.new("name","content",getMaxRecursionDepth()) }
        end
        def testParse
            tags = Tag.parse("\\name{content}");
            assert_equal(1,tags.length)
            assertEqTag("name", "content", tags[0])
        end

    private
        def assertEqTag(name, content, actual)
            assert_equal(name,actual.name())
            assert_equal(content,actual.content())
        end
        def createTagWithContent(content)
            Tag.new(@arbitraryName,content)
        end
    end # TestTag


    class TestTagFunctions < Test::Unit::TestCase
        def setup
            @names = ["name0","name1","name0"]
            @contents = ["contents0","contents1","contents2"]
            @tags = []
            @names.zip(@contents).each { |pair|
                @tags.push(Tag.new(pair[0],pair[1]))
            }
        end

        def testFindTagsByNameEmpty
            assert_empty(CvCreator::findTagsByName(@tags,"badName"))
        end
        def testFindTagsByName
            result = CvCreator::findTagsByName(@tags,"name0");
            assert_equal(2,result.length)
            assert_equal(@contents[0],result[0].content())
            assert_equal(@contents[2],result[1].content())
        end
        def testFindTagsContentByName
            assert_equal([@contents[0],@contents[2]], CvCreator::findTagsContentByName(@tags,"name0"))
        end
        def testFindTagContentByName
            assert_raise { CvCreator::findTagContentByName(@tags,"name0") }
            assert_equal(@contents[1], CvCreator::findTagContentByName(@tags,"name1"))
        end
    end # TestTagFunctions


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

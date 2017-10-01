require "test/unit"

module CvCreator

    class TestTag < Test::Unit::TestCase
        def setup
            @arbitraryName = "name"
        end

        def testCreate
            assertEqTag(@arbitraryName, "content", createTagWithContent("content"))
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

        def testMaxRecursionLevel
            assert_raise do
                Tag.new("name","content",getMaxRecursionLevel())
            end
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


    class Tag
        def initialize(name,content, recursionLevel = 0)
            if recursionLevel >= Tag.getMaxRecursionLevel()
                raise "Max recursion level " + Tag.getMaxRecursionLevel().to_s() + " reached."
            end

            @name = name
            @content = content
            @subtags = Tag.parseSubtags(content,recursionLevel)
        end

        def self.parse(text)
            parseSubtags(text,0)
        end

        def self.getMaxRecursionLevel()
            100
        end

        attr_reader :name, :content, :subtags

    private
        def self.parseSubtags(text,recursionLevel)
            tagList = []
            until text.empty?
                matched = Tag.subtagPattern.match(text)
                if !matched.nil?
                    text=matched.post_match
                    tagList.push(Tag.new(matched[:name],matched[:content],recursionLevel+1))
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

end # CvCreator


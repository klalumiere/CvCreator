require "test/unit"
require_relative "../lib/CvCreator/Tag"

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

end # CvCreator

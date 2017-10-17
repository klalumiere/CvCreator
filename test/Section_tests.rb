require "test/unit"
require_relative "../lib/CvCreator/Section"
require_relative "../lib/CvCreator/SectionView"

module CvCreator

    class ViewStub < CvCreator::SectionView
        def initialize(language)
            @language=language
        end
        def sectionHeader(title)
            title
        end
        
        def itemsName
            ["itemsNameOne","itemsNameTwo"]
        end
        def itemEssentialTag
            "itemEssentialTag"
        end
        def itemHeader(subsectionName)
            subsectionName
        end
        def itemBody(itemTag)
            CvCreator::findTagContentByName(itemTag.subtags,itemEssentialTag)
        end
        def itemFooter
            "itemFooter "
        end
        
        def subitemName
            "subitemName"
        end
        def subitemEssentialTag
            "subitemEssentialTag"
        end
        def subitemDefaultHeader
            "subitemDefaultHeader "
        end
        def subitemHeader
            "subitemHeader "
        end
        def subitemBody(subitemTag)
            CvCreator::findTagContentByName(subitemTag.subtags,subitemEssentialTag)
        end
        def subitemFooter
            "subitemFooter "
        end
        def subitemEmptyFooter
            "subitemEmptyFooter "
        end
        def subitemDefaultFooter
            "subitemDefaultFooter "
        end

        def removeUnwantedChars(text)
            text
        end
    end

    class TestSection < Test::Unit::TestCase
        def setup
            @language = "En"
            @view = ViewStub.new(@language)
            @class = "test"
            @options = { language: @language, classes: [@class] }
            @title = "arbitraryTitle"
            @minimalNonEmptyData = %q[\itemsNameOne{}\class{] + @class + %q[}\title]+@language+"{" + @title + "}"
        end
        def getSectionContentCustomOptions(data, options)
            CvCreator::Section.new(data,options,@view).content
        end
        def getSectionContent(data)
            getSectionContentCustomOptions(data,@options)
        end

        def testEmptyData
            assert_equal("", getSectionContent(""))
        end
        def testWrongItem
            actual = getSectionContent(%q[\wrongItem{}\class{] + @class + %q[}\title]+@language+"{ab}")
            assert_equal("",actual)
        end
        def testNoClasses
            newOptions = @options
            newOptions[:classes]=[""]
            actual = getSectionContentCustomOptions(@minimalNonEmptyData, newOptions)
            assert_equal("",actual)
        end
        def testItemInWrongGlobalClass
            actual = getSectionContent(%q[\itemsNameOne{}\class{notTest}\title]+@language+%q[{ab}])
            assert_equal("",actual)
        end
        def testEmptyItem
            actual = getSectionContent(%q[\itemsNameOne{}\class{] + @class + %q[}])
            assert_equal("",actual)
        end
        def testItemWithTitle
            assert_equal(@title, getSectionContent(@minimalNonEmptyData))
        end
        def testItemWithTitleWrongLanguage
            actual = getSectionContent(%q[\itemsNameOne{}\class{] + @class + %q[}\titleWrongLanguage{ab}])
            assert_equal("",actual)
        end
    end

    # class SectionTest < Test::Unit::TestCase
    #     def setup
    #         @data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }\class{fun}
    #             \itemsNameOneTitleFr{itemHeader }\itemsNameOneTitleEn{itemHeaderEn }\itemsNameOne{\itemEssentialTag{itemBody }}
    #             \itemsNameTwoTitleFr{itemHeader }\itemsNameTwoTitleEn{itemHeaderEn }]
    #         @options={language: "Fr", classes: ["fun"]}
    #         @view=ViewStub.new(@options[:language])
    #         @itemExpectedResult="itemHeader itemBody subitemEmptyFooter subitemDefaultFooter itemFooter "
    #     end
    #     def testGlobalClass
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult,result)
    #     end
    #     def testTwoItems
    #         @data+=%q[\itemsNameOne{\itemEssentialTag{itemBody2 }}]
    #         @itemExpectedResult="itemHeader itemBody subitemEmptyFooter subitemDefaultFooter itemBody2 subitemEmptyFooter subitemDefaultFooter itemFooter "
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult,result)
    #     end
    #     def testEnglish
    #         @options[:language]="En"
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         itemExpectedResultEn="itemHeaderEn itemBody subitemEmptyFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionHeader "+itemExpectedResultEn,result)
    #     end
    #     def testTwoItemType
    #         @data+=%q[\itemsNameTwo{\itemEssentialTag{itemBody }}]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         expectedResult="sectionEnTete "
    #         expectedResult+=@itemExpectedResult+@itemExpectedResult
    #         assert_equal(expectedResult,result)
    #     end
    #     def testSkipBadClassItem
    #         @data+=%q[\itemsNameTwo{\class{bad}\itemEssentialTag{itemBody }}]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult,result)
    #     end
    #     def testIncludeGoodClassItem
    #         @data+=%q[\itemsNameTwo{\class{fun}\itemEssentialTag{itemBody }}]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         expectedResult="sectionEnTete "
    #         expectedResult+=@itemExpectedResult+@itemExpectedResult
    #         assert_equal(expectedResult,result)
    #     end
    #     def testNoEssentialTag
    #         @data+=%q[\itemsNameTwo{\class{fun}}]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult,result)
    #     end
    #     def testSubitem
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\subitemEssentialTag{yo }}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         subitemExpectedResult="itemHeader itemBody subitemHeader yo subitemFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
    #     end
    #     def testTwoSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\subitemEssentialTag{yo1 }}
    #             \subitemName{\subitemEssentialTag{yo2 }}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         subitemExpectedResult="itemHeader itemBody subitemHeader yo1 yo2 subitemFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
    #     end
    #     def testBadClassSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\class{bad}\subitemEssentialTag{yo }}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult,result)
    #     end
    #     def testGoodClassSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\class{fun}\subitemEssentialTag{yo }}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         subitemExpectedResult="itemHeader itemBody subitemHeader yo subitemFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
    #     end
    #     def testBadAndGoodClassSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\class{fun}\subitemEssentialTag{yo1 }}
    #             \subitemName{\class{bad}\subitemEssentialTag{yo2 }}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         subitemExpectedResult="itemHeader itemBody subitemHeader yo1 subitemFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
    #     end
    #     def testNoEssentialTagSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\class{fun}}
    #             \subitemName{\class{bad}}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("sectionEnTete "+@itemExpectedResult+@itemExpectedResult,result)
    #     end
    #     def testSommeEssentialTagSubitems
    #         @data+=%q[\itemsNameTwo{
    #             \itemEssentialTag{itemBody }  
    #             \subitemName{\class{fun}\subitemEssentialTag{yo1 }}
    #             \subitemName{\class{fun}}
    #             }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         subitemExpectedResult="itemHeader itemBody subitemHeader yo1 subitemFooter subitemDefaultFooter itemFooter "
    #         assert_equal("sectionEnTete "+@itemExpectedResult+subitemExpectedResult,result)
    #     end
    #     def testNoItemAdded
    #         @data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("",result)
    #     end
    # end

    # class ClearedMockSectionView < ViewStub
    #     def removeUnwantedChars(text)
    #         ""
    #     end
    # end

    # class ClearedSectionTest < Test::Unit::TestCase
    #     def setup
    #         @data=%q[\titleFr{sectionEnTete }\titleEn{sectionHeader }\class{fun}
    #             \itemsNameOneTitleFr{itemHeader }\itemsNameOneTitleEn{itemHeaderEn }\itemsNameOne{\itemEssentialTag{itemBody }}
    #             \itemsNameTwoTitleFr{itemHeader }\itemsNameTwoTitleEn{itemHeaderEn }]
    #         @options={language: "Fr", classes: ["fun"]}
    #         @view=ClearedMockSectionView.new(@options[:language])
    #     end
    #     def testGlobalClassEmptyCleared
    #         @options[:classes]=[""]
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("",result)
    #     end
    #     def testGlobalClassCleared
    #         result=CvCreator::Section.new(@data,@options,@view).content
    #         assert_equal("",result)
    #     end
    # end

end # CvCreator

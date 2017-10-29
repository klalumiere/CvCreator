require "test/unit"
require_relative "../lib/CvCreator/Section"
require_relative "../lib/CvCreator/SectionView"

module CvCreator

    class ViewStub < CvCreator::SectionView
        def initialize(language)
        end
        def sectionHeader(title)
            title
        end
        
        def itemsName
            ["itemsNameOne"]
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
            @options = { language: "En", classes: ["test"] }
            @view = ViewStub.new("En")
            @expectedFooterNoSubitems = "subitemEmptyFooter subitemDefaultFooter itemFooter "
            @expectedFooterWithSubitems = "subitemFooter subitemDefaultFooter itemFooter "
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
            actual = getSectionContent(%q[\wrongItem{}\titleEn{ab}])
            assert_equal("",actual)
        end
        def testNoClassesInOptions
            newOptions = @options
            newOptions[:classes]=[""]
            actual = getSectionContentCustomOptions(%q[\itemsNameOne{}\class{test}\titleEn{ab}], newOptions)
            assert_equal("",actual)
        end
        def testItemInWrongGlobalClass
            actual = getSectionContent(%q[\itemsNameOne{}\class{notTest}\titleEn{ab}])
            assert_equal("",actual)
        end
        def testEmptyItem
            actual = getSectionContent(%q[\itemsNameOne{}])
            assert_equal("",actual)
        end
        def testItemWithClassAndGlobalTitle
            assert_equal("ab", getSectionContent(%q[\itemsNameOne{}\class{test}\titleEn{ab}]))
        end
        def testItemWithGlobalTitleWrongLanguage
            actual = getSectionContent(%q[\itemsNameOne{}\titleWrongLanguage{ab}])
            assert_equal("",actual)
        end
        def testItemWithTitle
            actual = getSectionContent(%q[\itemsNameOne{\itemEssentialTag{}}\itemsNameOneTitleEn{aTitle}])
            assert_equal("aTitle" + @expectedFooterNoSubitems,actual)
        end
        def testItemWithTitleWrongLanguage
            actual = getSectionContent(%q[\itemsNameOne{\itemEssentialTag{}}\itemsNameOneTitleWrongLanguage{aTitle}])
            assert_equal(@expectedFooterNoSubitems,actual)
        end
        def testItemWithBody
            actual = getSectionContent(%q[\itemsNameOne{\itemEssentialTag{aBody}}])
            assert_equal("aBody" + @expectedFooterNoSubitems,actual)
        end
        def testItemWithSubitem
            actual = getSectionContent(%q[\itemsNameOne{\itemEssentialTag{}\subitemName{ \subitemEssentialTag{body} }}])
            assert_equal("subitemHeader body" + @expectedFooterWithSubitems,actual)
        end
        def testItemWithSubitemAndBadClass
            data = %q[\itemsNameOne{\itemEssentialTag{}\subitemName{ \subitemEssentialTag{body}\class{notTest} }}]
            actual = getSectionContent(data)
            assert_equal("",actual)
        end

        class RemoveUnwantedCharsStub < ViewStub
            def removeUnwantedChars(text)
                ""
            end
        end
        def testRemoveUnwantedChars
            view = RemoveUnwantedCharsStub.new("En");
            actual = CvCreator::Section.new(%q[\itemsNameOne{\itemEssentialTag{aBody}}],@options,view).content
            assert_equal("",actual)
        end

        class NoEssentialSubitemTagStub < ViewStub
            def subitemEssentialTag
                ""
            end
        end
        def testNoEssentialSubitemTag
            view = NoEssentialSubitemTagStub.new("En");
            actual = CvCreator::Section.new(%q[\itemsNameOne{\itemEssentialTag{}\subitemName{}}],@options,view).content
            assert_equal("subitemHeader " + @expectedFooterWithSubitems,actual)
        end

    end

end # CvCreator

require "test/unit"
require_relative "../lib/CvCreator/SectionView"
require_relative "../lib/CvCreator/View"

module CvCreator
    class SectionViewStub < SectionView
        def sectionHeader(title)
            title
        end
        def itemsName
            ["itemsNameOne"]
        end
    end

    class ViewSpy < View
        attr_accessor :headerData
        attr_accessor :language

        def self.sectionToClass()
            {
                "sectionViewStub" => CvCreator::SectionViewStub,
            }
        end

        def convertSpecialChar(data)
            data = data.gsub("ab", "bc")
        end
        def footer
            "footer"
        end 
        def header(data,language)
            @headerData = data
            @language = language
            "header-"
        end
        def sectionFooter
            "-sectionFooter-"
        end
    end # ViewSpy

    class TestView < Test::Unit::TestCase
        def setup
            @headerTags = ViewSpy::HeaderDataKeys.map{ |key| Tag.new(key,"a" + key) }
            @dataHash = { "sectionViewStub" => %q[\itemsNameOne{}\titleEn{ab}] }
            @options = { :language => "En", classes: [] }
            @view = ViewSpy.new(@headerTags,@dataHash,@options)
        end

        def test_addSectionFooterIfNotEmpty_empty
            assert_equal("", @view.addSectionFooterIfNotEmpty(""))
        end
        def test_addSectionFooterIfNotEmpty
            assert_equal("notEmpty-" + @view.sectionFooter(), @view.addSectionFooterIfNotEmpty("notEmpty-"))
        end
        def test_createHeaderDataFromTags
            keys = [ "name" ]
            tags = [ Tag.new(keys[0] ,"ab") ]
            assert_equal({ keys[0] => @view.convertSpecialChar("ab") }, @view.createHeaderDataFromTags(keys,tags))
        end

        class CreateViewSpy
            attr_accessor :language
            def initialize(language)
                @language = language
            end
        end
        def test_createView
            assert_equal(@options[:language],@view.createView(CreateViewSpy).language)
        end

        def test_sectionContent
            sectionView = SectionViewStub.new(@options[:language])
            assert_equal("",@view.sectionContent(@dataHash["sectionViewStub"],sectionView))
        end

        def test_header_is_called_by_content
            @view.content
            assert_equal(@view.createHeaderDataFromTags(View::HeaderDataKeys,@headerTags),@view.headerData)
            assert_equal(@options[:language],@view.language)
        end
        def test_content
            assert_equal(@view.header("","") + @view.footer(), @view.content)
        end

    end

end # CvCreator

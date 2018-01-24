require "test/unit"
require_relative "../lib/CvCreator/Runner"

module CvCreator

    class ViewStub
        def self.sectionToClass()
            { "mySelf" => CvCreator::ViewStub }
        end
    end

    class TestRunner < Test::Unit::TestCase
        def setup
            @dataDirectory = "arbitraryDirectoryName"
            @viewClass = "HtmlView"
            @language = "En"
            @runner = Runner.new([@viewClass,@dataDirectory,@language])
        end

        def test_areArgumentsValidInvalidViewClass
            invalidRunner = Runner.new([])
            assert_false(invalidRunner.areArgumentsValid())
        end
        def test_areArgumentsValidInvalidDataDirectory
            invalidRunner = Runner.new([@viewClass])
            assert_false(invalidRunner.areArgumentsValid())
        end
        def test_areArgumentsValidTrue
            assert_true(@runner.areArgumentsValid())
        end
        def test_viewClassHtmlView
            assert_equal(CvCreator::HtmlView,@runner.viewClass)
        end
        def test_viewClassTexView
            withTexView = Runner.new(["TexView",@dataDirectory,@language])
            assert_equal(CvCreator::TexView,withTexView.viewClass)
        end
        def test_fileName
            assert_equal("name.tex",@runner.fileName("name"))
        end
        def test_filePath
            assert_equal("#{@dataDirectory}/name.tex",@runner.filePath("name"))
        end
        def test_sectionNames
            @runner.viewClass = ViewStub
            assert_equal(["mySelf"],@runner.sectionNames())
        end
        def test_dataDirectory
            assert_equal("#{@dataDirectory}/",@runner.dataDirectory())
        end
        def test_optionsLanguage
            assert_equal(@language,@runner.options()[:language])
        end
        def test_optionsClasses
            @runnerWithClasses = Runner.new([@viewClass,@dataDirectory,@language,"class1","class2"])
            assert_equal(["class1","class2"],@runnerWithClasses.options()[:classes])
        end
  
    end # TestRunner

end # CvCreator

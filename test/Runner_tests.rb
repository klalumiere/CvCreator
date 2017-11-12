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
            @language = "En"
            @runner = Runner.new([@dataDirectory,@language],ViewStub)
        end

        def test_areArgumentsValidInvalidDirectory
            invalidRunner = Runner.new([],ViewStub)
            assert_false(invalidRunner.areArgumentsValid())
        end
        def test_areArgumentsValidInvalidLanguage
            invalidRunner = Runner.new([@dataDirectory,"InvalidLanguage"],ViewStub)
            assert_false(invalidRunner.areArgumentsValid())
        end
        def test_areArgumentsValidTrue
            assert_true(@runner.areArgumentsValid())
        end
        def test_fileName
            assert_equal("name.tex",@runner.fileName("name"))
        end
        def test_filePath
            assert_equal("#{@dataDirectory}/name.tex",@runner.filePath("name"))
        end
        def test_sectionNames
            assert_equal(["mySelf"],@runner.sectionNames())
        end
        def test_dataDirectory
            assert_equal("#{@dataDirectory}/",@runner.dataDirectory())
        end
        def test_optionsLanguage
            assert_equal(@language,@runner.options()[:language])
        end
        def test_optionsClasses
            @runnerWithClasses = Runner.new([@dataDirectory,@language,"class1","class2"],ViewStub)
            assert_equal(["class1","class2"],@runnerWithClasses.options()[:classes])
        end
  
    end # TestRunner

end # CvCreator

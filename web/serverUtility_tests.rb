require "test/unit"
require_relative "serverUtility.rb"

module CvServer

    class TestTag < Test::Unit::TestCase
        def testSanitizeNoWhiteList
            assert_equal("indexHTMLrmfr",CvServer::sanitize("index.HTML && rm -fr"))
        end
        def testSanitize
            assert_equal("arbitrary_words",CvServer::sanitize("arbitrary_&&words",['_']))
        end
    end

end # CvServer

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
        def testCreateArgumentsListForHtmlEmptyArguments
            assert_equal(["HtmlView","data"],CvServer::createArgumentsListForHtml(""))
        end
        def testCreateArgumentsListForHtml
            assert_equal(["HtmlView","data","En","research"],CvServer::createArgumentsListForHtml("En__research"))
        end
        def testCreateArgumentsListForTexEmptyArguments
            assert_equal(["TexView","data"],CvServer::createArgumentsListForTex(""))
        end
        def testCreateArgumentsListForTex
            assert_equal(["TexView","data","En","research"],CvServer::createArgumentsListForTex("En__research"))
        end
        def testCreateStringFromFirstElementEmpty
            assert_equal("",CvServer::createStringFromFirstElement([]))
        end
        def testCreateStringFromFirstElement
            assert_equal("a",CvServer::createStringFromFirstElement(["a","b"]))
        end
    end

end # CvServer

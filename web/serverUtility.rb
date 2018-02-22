module CvServer

    def CvServer.createStringFromFirstElement(array)
        if array.empty?() then "" else array[0] end
    end

    def CvServer.createArgumentsListForHtml(arguments)
        createArgumentsListFor("HtmlView",arguments)
    end

    def CvServer.createArgumentsListForTex(arguments)
        createArgumentsListFor("TexView",arguments)
    end

    def CvServer.createArgumentsListFor(view,arguments)
        argumentList = [view,"data"]
        argumentList += CvServer::sanitize(arguments,['_']).split("__")
    end

    def CvServer.sanitize(input, whitelist = [])
        input.delete("^a-zA-Z0-9" + whitelist.join())
    end

end # CvServer

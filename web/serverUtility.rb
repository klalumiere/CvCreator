module CvServer

    def CvServer.createArgumentsListForHtml(arguments)
        argumentList = ["HtmlView","data"]
        argumentList += CvServer::sanitize(arguments,['_']).split("__")
    end

    def CvServer.sanitize(input, whitelist = [])
        input.delete("^a-zA-Z0-9" + whitelist.join())
    end

end # CvServer

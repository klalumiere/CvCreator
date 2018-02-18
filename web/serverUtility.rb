module CvServer

    def CvServer.sanitize(input, whitelist = [])
        input.delete("^a-zA-Z0-9" + whitelist.join())
    end

end # CvServer

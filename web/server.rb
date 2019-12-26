require "sinatra"
require_relative "serverUtility.rb"
require_relative "../lib/CvCreator/Runner"

set :environment, :production

HTTP_NOT_FOUND = 404

["/", "/cvInteractif"].each do |path|
    get path do
        File.read("web/index.html")
    end
end

get '/thirdParty/jquery.js' do
    content_type "text/javascript"
    File.read("web/thirdParty/jquery.js")
end

get '/CvManager.js' do
    content_type "text/javascript"
    File.read("web/CvManager.js")
end

get '/CvCreator/*' do
    input = CvServer::createStringFromFirstElement(params[:splat])
    runner = CvCreator::Runner.new(CvServer::createArgumentsListForHtml(input))
    runner.run
end

get '/CvCreatorTex/*' do
    input = CvServer::createStringFromFirstElement(params[:splat])
    runner = CvCreator::Runner.new(CvServer::createArgumentsListForTex(input))
    header = "<html><head><title>LaTeX CV</title></head><body><pre>\n"
    footer = "\n</pre></body></html>"
    header + runner.run + footer
end

get '*' do halt HTTP_NOT_FOUND end

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
    programInput = ""
    programInput += params[:splat][0] if !params[:splat].empty?()
    runner = CvCreator::Runner.new(CvServer::createArgumentsListForHtml(programInput))
    runner.run
end

get '/CvCreatorGem' do
  send_file "web/CvCreator-1.0.0.gem", :filename => "CvCreator-1.0.0.gem", :type => 'Application/octet-stream'
end

get '*' do halt HTTP_NOT_FOUND end

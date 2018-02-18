require "sinatra"
require_relative "../lib/CvCreator/Runner"

set :environment, :production

["/", "/cvInteractif"].each do |path|
    get path do
        File.read("index.html")
    end
end

get 'thirdParty/jquery.js' do
    File.read("thirdParty/jquery.js")
end

get 'CvManager.js' do
    File.read("CvManager.js")
end

get '/CvCreator/*' do
    argumentList = ["HtmlView ../data"]
    argumentList += CvServer::sanitize(params[:splat][0].split('__') if !params[:splat].empty?
    runner = CvCreator::Runner.new(argumentList)
    runner.run
end

get '/CvCreatorGem' do
  send_file "CvCreator-1.0.0.gem", :filename => "CvCreator-1.0.0.gem", :type => 'Application/octet-stream'
end

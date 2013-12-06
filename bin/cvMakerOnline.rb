require 'sinatra'
require_relative "../lib/cvMaker/runner.rb"
require_relative "../lib/cvMaker/htmlView"

set :environment, :production

["/", "/cvInteractif"].each do |path|
	get path do
		File.read("index.html")
	end
end

get '/jquery.js' do
	File.read("jquery.js")
end

get '/cvMaker/*' do
	argumentList=["data/"]
	splitParams=params[:splat][0].split('&') if !params[:splat].empty?
	argumentList+=splitParams
	runner=CvMaker::Runner.new(CvMaker::HtmlView,argumentList)
	runner.run
end

get '/cvMakerGem' do
  send_file "cvMaker-0.0.1.gem", :filename => "cvMaker-0.0.1.gem", :type => 'Application/octet-stream'
end

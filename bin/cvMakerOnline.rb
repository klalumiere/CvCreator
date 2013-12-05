require 'sinatra'
require_relative "../lib/cvMaker/runner.rb"
require_relative "../lib/cvMaker/htmlView"

get '/' do
	File.read("index.html")
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

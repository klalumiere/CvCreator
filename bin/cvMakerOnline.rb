require 'sinatra'
require_relative "../lib/cvMaker/runner.rb"

get '/cvMaker/*' do
	argumentList=["data/"]
	splitParams=params[:splat][0].split('&') if !params[:splat].empty?
	argumentList+=splitParams
	runner=CvMaker::Runner.new(argumentList)
	runner.run
end

Gem::Specification.new do |s|
	s.name = "cvMaker"
	s.summary = 
		"Using some LaTeX-type formatted files, as the sample files in the 'data' directory, this program outputs a CV ready to be compile by LaTeX. " 
	s.description = File.read(File.join(File.dirname(__FILE__), 'README')) 
	s.requirements = [ 'To be compile, this CV should use the included style-sheet resume2.cls.' ]
	s.version = "0.0.1"
	s.author = "Kevin Lalumiere"
	s.email = "kevin.lalumiere@gmail.com"
	s.license = "GPLv3"
	s.homepage = ""
	s.platform = Gem::Platform::RUBY
	s.required_ruby_version = '>=2.0' 
	allFiles=Dir['**/**']
	allFiles.delete("cvMaker.sublime-project").delete("cvMaker.sublime-workspace")
	s.files = allFiles
	s.executables = [ 'cvMaker' ]
	s.test_files = Dir["lib/cvMaker/*_test.rb"]
	s.has_rdoc = false
end

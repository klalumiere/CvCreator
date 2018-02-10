Gem::Specification.new do |s|
    s.name = "CvCreator"
    s.summary = "Use some LaTeX-like formatted data files to generate a CV in many languages with optional entries"
    s.description = File.read(File.join(File.dirname(__FILE__), 'README.md'))
    s.license = "MIT"
    s.requirements = []
    s.version = "1.0.0"
    s.author = "Kevin Lalumiere"
    s.email = "kevin.lalumiere@gmail.com"
    s.homepage = "http://fierce-hamlet-5053.herokuapp.com/cvInteractif"
    s.platform = Gem::Platform::RUBY
    s.required_ruby_version = '>=2.3'
    s.files = ["bin", "build", "build/.gitignore", "CvCreator.gemspec", "LICENSE", "lib", "README.md", "run.sh"] + \
        ["systemTests.sh", "test"] + Dir['bin/**'] + Dir['lib/**/**'] + Dir['test/**']
    s.executables = [ 'CvCreator' ]
    s.test_files = Dir["test/*_tests.rb"]
    s.has_rdoc = false
end
Gem::Specification.new do |s|
  s.name = "ruby-promobox"
  s.version = "0.0.1"
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage = "http://github.com/AF83/#{s.name}"
  s.authors = ["Laurent Arnoud"]
  s.email = "laurent.arnoud@af83.com"
  s.description = "Ruby API promobox"
  s.summary = "Ruby lib for talking with promobox API"
  s.extra_rdoc_files = %w(README.markdown)
  s.files = Dir["LICENSE", "README.markdown", "Gemfile", "lib/**/*.rb", 'test/**/*.rb']
  s.test_files = Dir.glob("test/*_test.rb")
  s.require_paths = ["lib"]
  s.add_dependency "multi_json", "~> 1.0"
  s.add_development_dependency "minitest", ">=2.0"
  s.add_development_dependency "rr", ">=1.0.5"
end

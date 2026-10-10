Gem::Specification.new do |spec|
  spec.name        = "rubocop-ubpb"
  spec.version     = "2.0.0"
  spec.authors     = ["René Sprotte"]
  spec.homepage    = "https://github.com/ubpb/rubocop-ubpb"
  spec.summary     = "Default RuboCop configuration for projects at UB Paderborn"
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.4"

  spec.metadata = {
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir["lib/**/*", "CHANGELOG.md", "MIT-LICENSE", "README.md", "rails.yml", "ruby.yml"]

  spec.add_dependency "rubocop", ">= 1.72.1", "< 2"
  spec.add_dependency "rubocop-minitest", ">= 0.37"
  spec.add_dependency "rubocop-performance", ">= 1.24"
end

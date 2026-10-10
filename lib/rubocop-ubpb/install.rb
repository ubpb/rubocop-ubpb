say "Installing default RuboCop configuration for Rails projects at UB Paderborn"

gem_group :development do
  gem "rubocop-rails", require: false
end

create_file ".rubocop.yml", <<~YML
  inherit_gem:
    rubocop-ubpb: rails.yml
YML

say "Run `bundle install` to install rubocop-rails."

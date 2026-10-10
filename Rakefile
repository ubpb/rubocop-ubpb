require "minitest/test_task"
require "rubocop/rake_task"

Minitest::TestTask.create do |t|
  t.test_globs = ["test/*_test.rb"]
end

RuboCop::RakeTask.new

task default: [:test, :rubocop]

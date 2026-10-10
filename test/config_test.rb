require_relative "test_helper"

class RubyConfigTest < Minitest::Test

  include RubocopRunner

  def test_plain_ruby_code_may_print_and_exit
    assert_offenses({"lib/tool.rb" => []}, rubocop("ruby.yml", "cli"))
  end

  def test_style_rules
    expected = {
      "lib/style_sample.rb" => [
        "Layout/SpaceInsideHashLiteralBraces", # `{ ` and ` }` are reported separately
        "Layout/SpaceInsideHashLiteralBraces",
        "Style/StringLiterals",
        "Style/StringLiteralsInInterpolation",
        "Style/WordArray"
      ]
    }

    assert_offenses(expected, rubocop("ruby.yml", "style"))
  end

  def test_minitest_cops_apply_to_tests
    assert_offenses({"test/sample_test.rb" => ["Minitest/AssertNil"]}, rubocop("ruby.yml", "minitest"))
  end

end

class RailsConfigTest < Minitest::Test

  include RubocopRunner

  def test_flags_output_and_exit_in_lib
    assert_offenses({"lib/tool.rb" => ["Rails/Exit", "Rails/Output"]}, rubocop("rails.yml", "cli"))
  end

  def test_inherits_style_rules_from_ruby_config
    expected = {
      "lib/style_sample.rb" => [
        "Layout/SpaceInsideHashLiteralBraces", # `{ ` and ` }` are reported separately
        "Layout/SpaceInsideHashLiteralBraces",
        "Style/StringLiterals",
        "Style/StringLiteralsInInterpolation",
        "Style/WordArray"
      ]
    }

    assert_offenses(expected, rubocop("rails.yml", "style"))
  end

  def test_inherits_plugins_from_ruby_config
    assert_offenses({"test/sample_test.rb" => ["Minitest/AssertNil"]}, rubocop("rails.yml", "minitest"))
  end

end

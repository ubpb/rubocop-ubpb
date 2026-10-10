require "minitest/autorun"
require "fileutils"
require "json"
require "open3"
require "tmpdir"

module RubocopRunner

  FIXTURES = File.expand_path("fixtures", __dir__)
  GEMFILE = File.expand_path("../Gemfile", __dir__)

  Result = Data.define(:offenses, :stderr)

  # Runs RuboCop the way a consuming project does: in a temporary project
  # whose .rubocop.yml inherits the given config via `inherit_gem`.
  def rubocop(config, fixture)
    Dir.mktmpdir("rubocop-ubpb") do |dir|
      FileUtils.cp_r(File.join(FIXTURES, fixture, "."), dir)
      File.write(File.join(dir, ".ruby-version"), "3.4\n")
      File.write(File.join(dir, ".rubocop.yml"), "inherit_gem:\n  rubocop-ubpb: #{config}\n")

      stdout, stderr, = Open3.capture3(
        {"BUNDLE_GEMFILE" => GEMFILE},
        "bundle", "exec", "rubocop", "--cache", "false", "--format", "json",
        chdir: dir
      )

      Result.new(offenses: offenses_by_file(stdout, stderr), stderr: stderr)
    end
  end

  # Fails on any RuboCop output on stderr (config warnings, pending cop
  # notices, plugin hints) before comparing the offenses.
  def assert_offenses(expected, result)
    assert_empty result.stderr, "RuboCop printed to stderr"
    assert_equal expected, result.offenses
  end

  private

  def offenses_by_file(stdout, stderr)
    JSON.parse(stdout).fetch("files").to_h do |file|
      [file["path"], file["offenses"].map { |offense| offense["cop_name"] }.sort]
    end
  rescue JSON::ParserError
    flunk "RuboCop did not produce JSON output:\n#{stdout}#{stderr}"
  end

end

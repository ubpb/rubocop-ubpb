require "minitest/autorun"

class SampleTest < Minitest::Test

  def test_value
    assert_equal(nil, value)
  end

  private

  def value
    nil
  end

end

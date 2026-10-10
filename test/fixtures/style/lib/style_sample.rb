module StyleSample

  GREETING = 'hello'.freeze
  WORDS = %w[a b].freeze
  OPTIONS = { a: 1 }.freeze

  def self.label(hash)
    "key: #{hash['key']}"
  end

end

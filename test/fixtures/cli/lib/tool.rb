module Tool

  def self.run(argv)
    if argv.empty?
      warn "usage: tool FILE"
      exit 1
    end

    puts argv.first
  end

end

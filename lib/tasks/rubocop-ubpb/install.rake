namespace "rubocop-ubpb" do
  desc "Install default RuboCop configuration for Rails projects at UB Paderborn"
  task :install do
    template = File.expand_path("../../rubocop-ubpb/install.rb", __dir__)
    system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{template}"
  end
end

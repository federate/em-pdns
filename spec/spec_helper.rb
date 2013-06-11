$:.push File.expand_path('../lib', __FILE__)
require 'bundler/setup'
require 'webmock/rspec'
require 'ffaker'

include PDNS

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each{|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  config.before(:suite) do
  end

  config.after(:suite) do
  end

end
require File.expand_path('../production',  __FILE__)

Sample::Application.configure do
  # Show errors when those happen
  config.consider_all_requests_local = true
end
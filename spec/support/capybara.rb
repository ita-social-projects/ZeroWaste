JS_DRIVER = :selenium_chrome
Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  end
  config.after(:each) do
    Capybara.use_default_driver
  end
end

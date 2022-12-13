JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :rack_test
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2

RSpec.configure do |config|
  config.before do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  end
  config.after do
    Capybara.use_default_driver
  end
end

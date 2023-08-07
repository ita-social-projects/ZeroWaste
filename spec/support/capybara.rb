Capybara.register_driver :chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 120

  Capybara::Selenium::Driver.new(app, {browser: :chrome, http_client: client})
end

JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :chrome
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 200

RSpec.configure do |config|
  config.before do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  end
  config.after do
    Capybara.use_default_driver
  end
end

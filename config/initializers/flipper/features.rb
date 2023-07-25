if Flipper::Adapters::ActiveRecord::Feature.table_exists?
  require_relative "flipper_feature"

  Flipper[:access_admin_menu].en_description = "This feature flag is responsible for visibility of 'Admin Menu' button on main page"
  Flipper[:access_admin_menu].uk_description = "Відкриває можливість заходити на сторінку адмінки авторизованим адмінам через верхнє меню посилань"
end

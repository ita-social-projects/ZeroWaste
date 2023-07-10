class AddAnAdminUser < ActiveRecord::Migration[6.1]
  def change
    User.create(
      email: "admin@zw.com",
      password: "ChangeMe1",
      password_confirmation: "ChangeMe1",
      first_name: "Admin",
      last_name: "Admin",
      confirmed_at: DateTime.current,
      role: "admin"
    )
  end
end

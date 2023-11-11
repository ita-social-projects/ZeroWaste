class ChangeUserAttributesNull < ActiveRecord::Migration[6.1]
  def up
    User.where(first_name: nil).each do |user|
      user.update(first_name: "Firstname")
      user.save(validate: false)
    end

    User.where(last_name: nil).each do |user|
      user.update(last_name: "Lastname")
      user.save(validate: false)
    end

    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end

  def down
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
  end
end

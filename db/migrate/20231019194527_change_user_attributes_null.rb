class ChangeUserAttributesNull < ActiveRecord::Migration[7.1]
  def up
    User.where(first_name: nil).each do |user|
      user.update(first_name: "Firstname")
      user.save(validate: false)
    end

    User.where(last_name: nil).each do |user|
      user.update(last_name: "Lastname")
      user.save(validate: false)
    end

    change_table :users, bulk: true do |t|
      t.change_null :first_name, false
      t.change_null :last_name, false
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.change_null :first_name, true
      t.change_null :last_name, true
    end
  end
end

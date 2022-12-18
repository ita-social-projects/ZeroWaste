# frozen_string_literal: true

class UsersCsvGenerator
  def initialize(users, fields:)
    @users  = users
    @fields = fields
  end

  def call
    CSV.generate do |csv|
      csv << @fields
      @users.each do |user|
        csv << user.attributes.values_at(*@fields)
      end
    end
  end

  def self.call(users, fields: User.column_names)
    new(users, fields: fields).call
  end
end

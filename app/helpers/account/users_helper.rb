# frozen_string_literal: true

module Account::UsersHelper
  def toggle_block_param(user)
    { blocked: !user.blocked }
  end

  def toggle_confirm(user)
    t(".confirm_#{user.blocked? ? "unblock" : "block"}")
  end

  def toggle_class(user)
    user.blocked? ? "lock" : "lock-open"
  end
end

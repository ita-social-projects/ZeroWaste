# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return unless user.admin?

    can :manage, Calculator
    can :manage, User
    can :manage, Message
  end
end

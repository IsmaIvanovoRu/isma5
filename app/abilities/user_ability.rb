class UserAbility
  include CanCan::Ability

  def initialize(user)
    can :show, User
    return unless user.present?
    return unless user.admin?
    can :manage, :all
  end
end

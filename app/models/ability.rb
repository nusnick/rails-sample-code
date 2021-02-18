class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all
      
      unless user.has_role?(:super_admin)
        cannot [:update, :view, :destroy, :toggle_status], User do |other_user|
          other_user.has_role?(:super_admin)
        end
      end
    else
      can :read, User
    end
    cannot :index, User, id: User.with_role(:super_admin).pluck(:id)
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Project, user: user
    can :manage, Task, project: { user_id: user.id }
  end
end
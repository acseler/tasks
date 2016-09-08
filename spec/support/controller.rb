module ControllerHelper
  def sign_in_as_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user, scope: :user)
    @request.headers.merge!(user.create_new_auth_token)
    session[:user_id] = user.id
  end

  def apply_ability
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(@controller).to receive(:current_ability).and_return(@ability)
  end

  def project_ability
    @ability.can :manage, Project, user_id: user.id
  end

  def task_ability
    @ability.can :manage, Project, user_id: user.id
    @ability.can :manage, Task, project: { user_id: user.id }
  end

  def comment_ability
    @ability.can :manage, Project, user_id: user.id
    @ability.can :manage, Task, project: { user_id: user.id }
    @ability.can :manage, Comment, task: { project: { user_id: user.id } }
  end

  def attachment_ability
    @ability.can :manage, Project, user_id: user.id
    @ability.can :manage, Task, project: { user_id: user.id }
    @ability.can :manage, Comment, task: { project: { user_id: user.id } }
    @ability.can :manage, Attachment,
                 comment: { task: { project: { user_id: user.id } } }
  end
end
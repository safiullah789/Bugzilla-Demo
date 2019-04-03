class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project


  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
  	@user.user_type != 'Developer'
  end

  def new?	
  	@user.user_type == 'Manager'
  end

  def edit?
	  @us_id = @project.users.where(id: @project.users.ids, user_type: 'Manager')
	  @usId = @us_id.ids[0]
    return @usId == @user.id
  end

  def destroy?
    @user.user_type == 'Manager'
  end

  def add_member?
    @user.user_type == 'Manager'
  end

  def remove_member?
    @user.user_type == 'Manager'
  end

  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end


end

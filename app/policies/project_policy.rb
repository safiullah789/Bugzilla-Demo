class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project


  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
  	# @user.user_type != 'Developer'
  end

  def new?
  	@user.user_type == 'Manager'
  end


  def show?
  	if @user.user_type == 'Developer'
  		@project.users.include?(@user)
  	else
  		return true
  	end
  end

  def edit?
    if @user.user_type == 'Manager'
      @project.users.include?(@user)
    else
      return false
    end
  end


  def destroy?
  	if @user.user_type == 'Manager'
      @project.users.include?(@user)
    else
      return false
    end
  end

  def add_member?
  	if @user.user_type == 'Manager'
      @project.users.include?(@user)
    else
      return false
    end
  end

  def remove_member?
		if @user.user_type == 'Manager'
      @project.users.include?(@user)
    else
      return false
    end
  end



end

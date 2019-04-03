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
	  @user_Obj = @project.users.where(id: @project.users.ids, user_type: 'Manager')
	  @usId = @user_Obj.ids[0]
    return @usId == @user.id
  end

  def destroy?
  	@user_Obj = @project.users.where(id: @project.users.ids, user_type: 'Manager')
	  @usId = @user_Obj.ids[0]
    return @usId == @user.id
  end

  def add_member?
  	@user_Obj = @project.users.where(id: @project.users.ids, user_type: 'Manager')
	  @usId = @user_Obj.ids[0]
    return @usId == @user.id
  end

  def remove_member?
		@user_Obj = @project.users.where(id: @project.users.ids, user_type: 'Manager')
	  @usId = @user_Obj.ids[0]	
    return @usId == @user.id
  end

  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end


end

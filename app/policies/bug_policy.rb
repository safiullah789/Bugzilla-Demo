class BugPolicy < ApplicationPolicy

	attr_reader :user, :bug

  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  def new?
    @user.user_type == 'QA'
  end

  def show?
  	if @user.user_type == 'Developer'
  		@bug.project.users.include?(@user)
  	else
  		return true
  	end
  end

  def assign?
    if @user.user_type == 'Developer'
      @bug.project.users.include?(@user) and @bug.dev_id == nil
    else
      return false
    end
  end

  def edit_status?
    if @user.user_type == 'Developer'
      @bug.project.users.include?(@user) and @bug.dev_id == @user.id
    else
      return false
    end
  end


  def edit?
    if @user.user_type == 'QA'
      @bug.project.users.include?(@user) and @bug.user == @user
    else
      return false
    end
  end

  def destroy?
    if @user.user_type == 'QA'
      @bug.project.users.include?(@user) and @bug.user == @user
    else
      return false
    end
  end

end

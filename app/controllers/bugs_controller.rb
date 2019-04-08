class BugsController < ApplicationController

  before_action :find_project , except: :edit_status
  before_action :find_bug, only: [:show, :edit, :update, :destroy, :assign, :edit_status]
  before_action :find_user, except: :edit_status

	def index
		@bugs = @project.bugs
	end

	def new
		@bug = @project.bugs.build
    authorize @bug
	end

  def show
  	authorize @bug
  end

  def edit
    authorize @bug
  end

	def create
  		@bug = @project.bugs.create(bug_params)
  		if @bug.save
  			redirect_to project_bug_path(@project, @bug)
  		else
  		   render 'new'
  		end
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_bug_path(@project, @bug)
    else
      render 'edit'
    end
  end

  def destroy
    authorize @bug
    @bug.destroy
    redirect_to project_bugs_path(@project)
  end

  def assign
    authorize @bug
    @bug.update_attribute(:dev_id,current_user.id)
    redirect_to project_bug_path(@bug.project_id, @bug)
  end

  def edit_status
    authorize @bug
    if @bug.update_attribute(:bug_status, params[:data])
      render json: {"message": "Successfully Updated"}
    else
      render json: {"erroe": "Could not update"}
    end
  end




  private
  	def bug_params
     # puts "--------------"*50
     # puts params.inspect
     # puts "--------------"*50

   	 params.require(:bug).permit(:title, :deadline, :screenshot, :bug_type, :bug_status, :user_id, :dev_id)
  	end

	  def find_project
  	  @project = Project.find(params[:project_id])
  	end

  	def find_bug
  	  @bug = Bug.find(params[:id])
  	end

    def find_user
      @user = current_user.id
    end

end

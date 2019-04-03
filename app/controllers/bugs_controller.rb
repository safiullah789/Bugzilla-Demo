class BugsController < ApplicationController

  before_action :find_project

	def index
		@bugs = @project.bugs
	end

	def new
		@bug = @project.bugs.build		
	end

  def show
    @bug= @project.bugs.find(params[:id])
  end

  def edit
    @bug = @project.bugs.find(params[:id])
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
    @bug = @project.bugs.find(params[:id])
    
    if @bug.update(bug_params)
      redirect_to project_bug_path(@project, @bug)
    else
      render 'edit'
    end
  end

  def destroy
    @bug = @project.bugs.find(params[:id])
    @bug.destroy
    redirect_to project_bugs_path(@project)
  end


  private
  	def bug_params
   	 params.require(:bug).permit(:title, :deadline, :screenshot, :type, :status)
  	end

	  def find_project
  	  @project = Project.find(params[:project_id])
  	end

end

class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy, :add_member, :remove_member]

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
		authorize @project
	end

	def show
		authorize @project
		@all_users = User.where.not(id: @project.users.ids, user_type: 'Manager')
		@user_project = @project.user_projects.build
	end

	def edit
		authorize @project
	end

	# def edit
	# 	@project = current_user.projects.find(params[:id]) where user can only edit his/her own projects
	# end

	def create
		@project = current_user.projects.create(project_params)
		if @project.save
			redirect_to project_path(@project), notice: 'Project Savad'
		else
			render 'new'
		end
	end

	def update
		if @project.update(project_params)
			redirect_to project_path(@project), notice: 'Project Updated'
		else
			render 'edit'
		end
	end

	def destroy
		authorize @project
		@project.destroy
		redirect_to projects_path(@project)
	end

	def add_member
		authorize @project
		@project.users << User.where(id: params[:users][:id])
		redirect_to project_path(@project), notice:  'User(s) Added'
	end

	def remove_member
		authorize @project
		@user = @project.user_projects.where(user_id: params[:user_id])
		@project.user_projects.delete(@user)
		redirect_to project_path(@project), notice:  'User Removed'
	end

	private
		def project_params
			params.require(:project).permit(:title, :description, :user_ids)
		end

		def set_project
			@project = Project.find_by(id: params[:id])
			# // asda
		end

end



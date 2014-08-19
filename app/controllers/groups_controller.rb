class GroupsController < ApplicationController
	def new
		@user = current_user
		@groupname = params[:group_name]
	end
	
	def show
		@user = current_user
		@viewname = params[:group_name]
	
	end

	def index
		@user = current_user
		@row_iterator = @user.contacts.select('DISTINCT group_name')
	end

	def add_group
		@user = current_user
	end


end

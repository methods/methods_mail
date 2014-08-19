class GroupsController < ApplicationController
	def new
		@user = User.find(params[:id])
		@groupname = params[:group_name]
	end
	
	def show
		@user = current_user
		@viewname = params[:group_name]
		split_name = @viewname.split(" ")
		@url_name = split_name.join("+")	
	end

	def index
		@user = current_user
		@row_iterator = @user.contacts.select('DISTINCT group_name')
	end

	def add_group
		@user = current_user
	end

	def thank_you
		
	end

end

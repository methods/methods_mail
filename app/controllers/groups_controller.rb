class GroupsController < ApplicationController
	def new
		@user = current_user
	
	end
	
	def show
		@user = current_user
	
	end

	def index
		@user = current_user
		@group_name = @user.contacts.select('DISTINCT group_name')
	end
end

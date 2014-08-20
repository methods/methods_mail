class GroupsController < ApplicationController
	def new
		@user = User.find(params[:id])
		@groupname = params[:group_name]
	end
	
	def show
		if signed_in?
			@user = current_user
			@viewname = params[:group_name]
			split_name = @viewname.split(" ")
			@url_name = split_name.join("+")	
		else
			redirect_to root_url
		end
	end

	def index
		if signed_in
			@user = current_user
			@row_iterator = @user.contacts.select('DISTINCT group_name')
		else
			redirect_to root_url
		end
	end

	def add_group
		if signed_in?
			@user = current_user
		else
			redirect_to root_url
		end
	end

	def thank_you
		
	end

end

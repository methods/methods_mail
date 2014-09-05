class ContactsController < ApplicationController
  include ContactsHelper
	def new
		if signed_in?
			@user = current_user
			@contact = Contact.new
		else
			redirect_to root_url
		end
	end

	def create
		if signed_in?
			@user = User.find(params[:user_id])
			@contact = @user.contacts.create(contact_params)
			if @contact.group_name.nil?
				@contact.group_name = "default"
			end
			if @contact.save
				redirect_to user_path(@user)
			else
				render 'new'
			end
		else
			redirect_to root_url
		end
	end

	def edit
		if signed_in?
			@user = User.find(params[:user_id])
			@contact = Contact.find(params[:id])
		else
			redirect_to root_url
		end
	end

	def update
		if signed_in?
			@user = User.find(params[:user_id])
			@contact = Contact.find(params[:id])
			@new_name = (contact_params[:name])
			@new_email = (contact_params[:email])
			@contacts = @user.contacts.select('name','email', 'id')
			@update = false
			@contacts.each do |element|
				if element.email == @contact.email
					Contact.find(element.id).update(name: @new_name, email: @new_email)
					@update = true
				end
			end
			if @update
				redirect_to root_url
			else
				flash.now[:error] = "Failed to update contact details"
			    render 'edit'
			end
		else
			redirect_to root_url
		end
	end

	def destroy
		if signed_in?
			@user = User.find(params[:user_id])
			@contact = Contact.find(params[:id])
			@contacts = @user.contacts.select('name','email', 'id')
			@update = "blank"
			@contacts.each do |element|
				if element.email == @contact.email
					Contact.find(element.id).destroy
				end
			end
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	def delete_group
		if signed_in?
			@user = current_user
			@contact = Contact.find(params[:id])
			@contacts = @user.contacts.select('name','email','id','group_name')
			@output ="blank"
			@contacts.each do |element|
				if element.group_name == @contact.group_name
					Contact.find(element.id).destroy
				end
			end
			redirect_to groups_path(@user)
		else
			redirect_to root_url
		end
	end

	def remove_group_member
		if signed_in?
			@user = current_user
			@contact = Contact.find(params[:id])
			@group_locator = @contact.group_name
			@contact.destroy
			redirect_to group_path(@user, group_name: @group_locator)
		else
			redirect_to root_url
		end
	end

	def add_group_member_list_show
		if signed_in?
			@user = current_user
			@contacts = @user.contacts.all
			@groupname = params[:group_name]
			@non_member_list = generate_non_group_member_list(@contacts, @groupname)
		else
			redirect_to root_url
		end
	end

	def add_group_member
		if signed_in?
			@user = current_user
			@contact = Contact.find(params[:id])
			@group_contact = Contact.new(name: @contact.name, email: @contact.email)
			@group_contact.group_name = params[:group_name]
			@group_contact.user_id = @user.id
			if @group_contact.save
				flash.now[:success] = "Contact added to group"
			else
				flash.now[:error] = "Failed to add contact to group"
			end
			redirect_to add_group_member_path(group_name: @group_contact.group_name)
		else
			redirect_to root_url
		end
	end

	def add_new_group_contact
		@user = User.find(params[:id])
		@group_contact = @user.contacts.create(contact_params)
		@non_group_contact = @user.contacts.create(contact_params)
		@non_group_contact.group_name = "default"
		if @group_contact.save && @non_group_contact.save
			if signed_in?
				redirect_to user_path(@user)
			else
				redirect_to Thank_You_path(@user)
			end
		else
			render 'groups#new'
		end
	end


	private
		def contact_params
			params.require(:contact).permit(:name, :email, :group_name)
		end

end

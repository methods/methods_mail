class ContactsController < ApplicationController

	def new
		@user = current_user
		@contact = Contact.new
	end

	def create
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
	end

	def edit
		@user = User.find(params[:user_id])
		@contact = Contact.find(params[:id])
	end

	def update
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
	end

	def destroy
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
	end

	def delete_group
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
	end

	def remove_group_member
		@user = current_user
		@contact = Contact.find(params[:id])
		@group_locator = @contact.group_name
		@contact.destroy
		redirect_to group_path(@user, group_name: @group_locator)
	end

	private
		def contact_params
			params.require(:contact).permit(:name, :email, :group_name)
		end

end

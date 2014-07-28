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

	private
		def contact_params
			params.require(:contact).permit(:name, :email, :group_name)
		end

end

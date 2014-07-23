class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def create
		@user = User.find(params[:user_id])
		@contact = @user.contacts.create(contact_params)
		if @contact.group.nil?
			@contact.group = "default"
		end
		if @contact.save
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	private
		def contact_params
			params.require(:contact).permit(:name, :email, :group)
		end

end

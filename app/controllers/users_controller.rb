class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in(@user)
      flash[:success] = "Account created successfully"
  		redirect_to user_path(@user)
  	else
      flash.now[:error] = "Failed to create account"
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def delete_account
    @user = User.find(params[:id])
  end

  def delete_confirmed
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:user][:password])
      sign_out
      @user.destroy
      flash[:success] = "Account successfully deleted"
      redirect_to root_url
    else
      flash.now[:error] = "Incorrect password entered"
      render 'delete_account'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @new_name = (user_params[:name])
    @new_email = (user_params[:email])
    if @user && @user.authenticate(params[:user][:password])
      if User.find(@user.id).update_attribute(:email, @new_email) && User.find(@user.id).update_attribute(:name, @new_name)
        redirect_to root_url 
        flash[:success] = "Account details successfully updated" 
      else
        flash.now[:error] = "Failed to update account details"
        render 'edit'
      end
    else
      flash.now[:error] = "Incorrect password entered"
      render 'edit'
    end
  end

  def change_password_form
    @user = current_user
  end

  def change_password
    @user = current_user
    @new_password = (params[:user][:password])
    @old_password = (user_params[:old_password])
    @confirm_password = (user_params[:password_confirmation])
    @update_user = User.new(name: @user.name, email: @user.email, password: @new_password, password_confirmation: @confirm_password)
    if @user && @user.authenticate(params[:user][:old_password])
      @update_user.save
      if @user.update_attribute(:password_digest, @update_user.password_digest)
        flash[:success] = "Password successfully changed"
        redirect_to root_url
      else
        flash[:error] = "Password change failed"
        render 'change_password_form'
      end
      @update_user.destroy
    else
      flash[:error] = "Incorrect password entered"
      render 'change_password_form'
    end
    
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :old_password)
  	end
end

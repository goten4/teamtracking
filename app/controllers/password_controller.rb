class PasswordController < ApplicationController

  before_filter :login_required
  before_filter :find_user

  def edit
  end

  def update
    if User.authenticate(current_user.login, params[:user][:old_password])
      if @user.update_attributes(params[:user])
        flash[:notice] = "Le mot de passe a bien été modifié"
        redirect_to user_path(@user)
      else
        render :action => 'edit'
      end
    else
      flash[:error] = "Mot de passe incorrect"
      render :action => 'edit'
    end
  end

protected

  def find_user
    @user = current_user
  end

end

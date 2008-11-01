class UsersController < ApplicationController
  
  before_filter :find_user_or_current_user, :only => [:show, :edit, :update]
  before_filter :find_user, :only => [:destroy]
  # Protect these actions behind an admin login
  before_filter :check_administrator_role, :only => [:index, :new, :create, :destroy]
  
  # only an administrator should see all the users
  def index
    @users = User.find(:all)
  end
  
  # users can view their own profile, administrators can view any
  def show
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])
    @user.save! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_to users_path
      flash[:notice] = "L'utilisateur #{@user.login} a bien été créé"
    else
      flash[:error]  = "Echec lors de la création de l'utilisateur"
      render :action => 'new'
    end
  end

  # users can edit their own profile, administrators can edit any
  def edit
  end

  # users can update their own profile, administrators can update any
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Le profil a bien été modifié"
      redirect_to user_path(@user)
    else
      render :action => 'edit'
    end
  end

  # only for an administrator (same as purge, removes a user completely)
  def destroy
    if @user != current_user
      @user.destroy
    else
      flash[:error]  = "Vous ne pouvez pas supprimer votre compte utilisateur"
    end
    redirect_to users_path
  end
  
protected

  def find_user
    @user = User.find(params[:id])
  end
  
  def find_user_or_current_user
    if current_user.has_role?('administrator')
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end

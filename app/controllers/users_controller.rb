class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users/:id
  def create
    @user = User.new user_create_params
    if @user.save
      flash.notice = 'User successfully created'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  # GET /users/:id/edit
  def edit; end

  # GET /users/login
  def login; end

  # PUT /users/:id
  def update
    if @user.update user_update_params
      flash.notice = 'User successfully updated'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_create_params
    params.require(:user).permit(:email, :image_file)
  end

  def user_update_params
    params.require(:user).permit(:image_file)
  end
end

class UsersController < ApplicationController
  before_action :find_user, only: %i[edit show update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "#{@user.username} 已註冊成功！"
    else
      @error_message = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: '更新帳戶成功'
    else
      @error_message = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    redirect_to users_path, notice: '刪除帳戶成功' if @user.destroy
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
class SessionsController < ApplicationController
  before_action :find_session_user, only: %i[create delete]

  def new; end
  # 使用者登入
  def create
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      cookies.signed['user.id'] = @user.id
      # 登入系統 60分鐘後， 交易平台的頻道就會失去連接
      cookies.signed['user.expires_at'] = 60.minutes.from_now
      flash[:notice] = '成功登入'
      redirect_to commodities_path(@user)
    else
      if params[:session][:email] == ''
        redirect_to login_path, notice: 'Email 不可空白'
      elsif params[:session][:password] == ''
        redirect_to login_path, notice: '密碼 不可空白'
      else
        redirect_to login_path, notice: '使用者資料輸入錯誤'
      end
    end
  end
  # 使用者登出
  def destroy
    session[:user_id] = nil
    cookies.signed['user.id'] = nil
    cookies.signed['user.expires_at'] = nil
    redirect_to root_path, notice: '已登出'
  end

  private

  def find_session_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      # 处理注册成功的情况
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
      #不过，也可以写成：
      #redirect_to user_url(@user)
      #Rails 看到redirect_to @user 后
      #知道我们是想重定向到user_url(@user)
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, 
                                 :email,
                                 :password, 
                                 :password_confirmation)
  end
end

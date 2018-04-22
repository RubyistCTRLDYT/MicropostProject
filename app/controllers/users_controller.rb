class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page:  params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      # 处理注册成功的情况
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url 
      #不过，也可以写成：
      #redirect_to user_url(@user)
      #Rails 看到redirect_to @user 后
      #知道我们是想重定向到user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update_attributes(user_params)
      # 处理更新成功的情况
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

=begin
  # 确保用户已登录
  def logged_in_user
    #如果 logged_in? 返回真 返回
    #否则 运行下面
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
=end

  # 确保是正确的用户
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User was successfully deleted"
    redirect_to users_url
  end

  # 确保是管理员
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private
  def user_params
    params.require(:user).permit(:name, 
                                 :email,
                                 :password, 
                                 :password_confirmation)
  end

end

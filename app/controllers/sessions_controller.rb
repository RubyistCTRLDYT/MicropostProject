class SessionsController < ApplicationController
    def new
        
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            # 登入用户，然后重定向到用户的资料页面
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_to user
        else
            # 创建一个错误消息
            #把flash 换成特殊的flash.now。flash.now 专门用于在重新渲染的
            #页面中显示闪现消息。与flash 不同的是，
            #flash.now 中的内容会在下次请求时消失
            flash.now[:danger] = 'Invalid email/password combination' # 不完全正确
            render 'new'
        end
    end
    
    def destroy
        log_out if logged_in?
        redirect_to root_url  
    end

   

end

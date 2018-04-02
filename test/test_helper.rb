require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?

    #puts "!session[:user_id].nil?"
    #puts (!session[:user_id].nil?)
    return (!session[:user_id].nil?)
  end

  # 登入指定的用户
  def log_in_as(user) 
    session[:user_id] = user.id  
  end

  def logout(user)
    session.delete(:user_id)
  end

end

class ActionDispatch::IntegrationTest
  # 登入指定的用户
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
=begin
    if user.activated?
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
=end
  end
end

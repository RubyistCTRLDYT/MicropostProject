require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "login with invalid information" do 
    get login_path                    #访问登录页面；        
    assert_template 'sessions/new'    #确认正确渲染了登录表单；
    post login_path, params: { session: { email: "", password: "" } }#提交无效的params 散列，向登录路径发起post 请求；
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

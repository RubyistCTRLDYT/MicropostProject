require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  # test "the truth" do
  #   assert true
  # end
  #我们要编写一个测试，模拟图 8.5 和图 8.6 中的连续操作。基本的步骤如下：
  #1. 访问登录页面；
  #2. 确认正确渲染了登录表单；
  #3. 提交无效的params 散列，向登录路径发起post 请求；
  #4. 确认重新渲染了登录表单，而且显示了一个闪现消息；
  #5. 访问其他页面（例如首页）；
  #6. 确认这个页面中没显示前面那个闪现消息。
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  #1. 访问登录页面；
  #2. 通过post 请求发送有效的登录信息；
  #9. 可能要重启 Web 服务器。
  #3. 确认登录链接消失了；
  #4. 确认出现了退出链接；
  #5. 确认出现了资料页面链接。
  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end

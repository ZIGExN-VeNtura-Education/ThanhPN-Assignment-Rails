require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    super
    @admin = users(:admin)
    @mod = users(:moderator)
    @guest = users(:guest)
  end

  test "Redirect when no logged" do
    get admin_path
    assert_redirected_to new_user_session_path
  end

  test "Redirect when logged with non manager account" do
    get admin_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    post new_user_session_path(
           params:
             { user:
                 {
                   email: @guest.email,
                   password: '123456'
                 }
             }
         )
    assert_redirected_to root_path
    get admin_path
    assert_redirected_to root_path

  end

  test "Accept when logged by moderator account" do
    get admin_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    post new_user_session_path(
           params:
             { user:
                 {
                   email: @mod.email,
                   password: '123456'
                 }
             }
         )
    assert_redirected_to root_path
    get admin_path
    assert_equal "show", @controller.action_name
  end

  test "Accept when logged by admin account" do
    get admin_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    post new_user_session_path(
           params:
             { user:
                 {
                   email: @admin.email,
                   password: '123456'
                 }
             }
         )
    assert_redirected_to root_path
    get admin_path
    assert_equal "show", @controller.action_name
  end
end

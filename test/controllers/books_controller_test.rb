require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @book = books(:one)
    @admin = users(:admin)
    @mod = users(:moderator)
    @guest = users(:guest)
  end

  test "Guest cannot access book info" do
    get book_path(@book.id)
    assert_redirected_to new_user_session_path
  end

  test "logged user can access book info" do
    get book_path(@book.id)
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
    get book_path(@book.id)
    assert_response :success
  end

  test "non moderator user cannot access book create" do
    get new_book_path(@book.id)
    assert_redirected_to new_user_session_path
  end

end

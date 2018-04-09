require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
    @other_user = users(:john)
  end

  test "should redirect when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: "al", email: "al@al.com", password: "password" } }
    end

    assert_redirected_to root_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_url(@user), params: { user: { email: "bob2@yahoo.com", name: "bob2", password_digest: "password2" } }
    assert_redirected_to user_url(@user)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      log_in_as(@user)
      delete user_url(@other_user)
    end
    assert_redirected_to users_url
  end

  test "should not destroy user if not admin" do
    assert_difference('User.count', 0) do
      log_in_as(@other_user)
      delete user_url(@user)
    end
    assert_redirected_to root_url
  end
end

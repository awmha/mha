require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:bob)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'p.user-name', text: @user.name
    assert_match @user.projects.count.to_s, response.body
  end
end

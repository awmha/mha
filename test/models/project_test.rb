require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @user = users(:bob)
    @project = @user.projects.build(name: "Name", location: "Location")
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "user id should be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end

  test "name and loc should be present" do
    @project.location = " "
    assert_not @project.valid?
  end

  test "name and loc should be at most 50 characters" do
    @project.name = "a" * 51
    assert_not @project.valid?
  end
end

require 'test_helper'

class ProjectInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
  end

  test "project interface" do
    log_in_as(@user)
    get new_project_path
    assert_select 'input[type=text]'
    #invalid submission
    post projects_path, params: { project: { location: "" } }
    assert_select 'div#error_explanation'
    #valid submission
    name = "Nice Project"
    location = "New York"
    image = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Project.count', 1 do
      post projects_path, params: { project: { name: name, location: location, images: [image] } }
    end
    follow_redirect!
    assert_match name, response.body
    assert_match location, response.body
    assert_match 'rails.png', response.body
    #delete a post
    get root_path
    assert_select 'a', 'Destroy'
    first_project = @user.projects.first
    assert_difference 'Project.count', -1 do
      delete project_path(first_project)
    end
    #visit a different user
    get user_path(users(:john))
    assert_select 'a', { text: 'delete', count: 0}
  end
end
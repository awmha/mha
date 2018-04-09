require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one_project)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    log_in_as(users(:bob))
    assert_difference('Project.count') do
      post projects_url, params: { project: { location: @project.location, name: @project.name, user_id: @project.user_id } }
    end
    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { location: @project.location, name: @project.name, user_id: @project.user_id } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project if logged in as admin" do
    log_in_as(users(:bob))
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end
    assert_redirected_to projects_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Project.count' do
      post projects_path, params: {project: { name: "Lorem Ipsum"} }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Project.count' do
      delete project_path(@project)
    end
    assert_redirected_to login_url
  end
end

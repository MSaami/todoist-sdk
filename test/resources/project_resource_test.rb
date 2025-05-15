require 'test_helper'

class ProjectResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_add_project
    stub_request(:post, Todoist::Config::URLS[:projects])
      .to_return(status: 200, body: File.read('test/fixtures/project.json'))

    project = @client.projects.add('Test Project')
    assert_equal 'Test Project', project.name
  end

  def test_list_project
    stub_request(:get, Todoist::Config::URLS[:projects])
      .to_return(status: 200, body: File.read('test/fixtures/projects.json'))

    projects = @client.projects.all
    assert_instance_of Todoist::Collection, projects
    assert_equal 2, projects.count

    project = projects.first
    assert_equal 'Test Project', project.name
  end

  def test_delete_project
    project_id = '6Jf8VQXxpwv56VQ7'
    stub_request(:delete, Todoist::Config::URLS[:delete_project].gsub(':project_id', project_id))
      .to_return(status: 204)

    assert @client.projects.delete(project_id)
  end

  def test_update_project
    project_id = '6Jf8VQXxpwv56VQ7'
    stub_request(:post, Todoist::Config::URLS[:update_project].gsub(':project_id', project_id))
      .to_return(status: 200, body: File.read('test/fixtures/project.json'))

    project = @client.projects.update(project_id, name: 'Test Project')
    assert_instance_of Todoist::Entities::Project, project
  end

  def test_retrieve_project
    project_id = '6Jf8VQXxpwv56VQ7'
    stub_request(:get, Todoist::Config::URLS[:get_project].gsub(':project_id', project_id))
      .to_return(status: 200, body: File.read('test/fixtures/project.json'))

    project = @client.projects.retrieve(project_id)
    assert_instance_of Todoist::Entities::Project, project
    assert_equal 'Test Project', project.name
  end

  def test_projects_pagination
    stub_request(:get, Todoist::Config::URLS[:projects])
      .with(query: { cursor: 'fake_cursor' })
      .to_return(status: 200, body: File.read('test/fixtures/projects.json'))

    projects = @client.projects.all(cursor: 'fake_cursor')

    assert_equal 2, projects.count
    assert_equal 'next_cursor_value', projects.next_cursor
  end
end

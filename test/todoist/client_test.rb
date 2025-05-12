require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_token
    assert_equal 'test_token', @client.token
  end

  def test_projects_resource
    assert_instance_of Todoist::ProjectResource, @client.projects
  end

  def test_user_resource
    assert_instance_of Todoist::UserResource, @client.user
  end

  def test_handle_response_raises_error_on_failure
    stub_request(:get, Todoist::Config::URLS[:projects])
      .to_return(status: 401, body: "Unauthorized")

    error = assert_raises(Todoist::Error) do
      @client.get_request(Todoist::Config::URLS[:projects])
    end

    assert_equal 401, error.code
    assert_equal "Unauthorized", error.message
  end


end

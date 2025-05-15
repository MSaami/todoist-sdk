require 'test_helper'

class UserResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_get_user
    stub_request(:get, Todoist::Config::URLS[:user])
      .to_return(status: 200, body: File.read('test/fixtures/user.json'))
    user = @client.user.info
    assert_equal 'Mehrdad Sami', user['full_name']
  end
end

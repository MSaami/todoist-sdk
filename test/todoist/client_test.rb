require 'test_helper'

class ClientTest < Minitest::Test
  def test_token
    client = Todoist::Client.new('test_token')
    assert_equal 'test_token', client.token
  end
end

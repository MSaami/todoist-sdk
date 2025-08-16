require 'test_helper'

class FileResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_delete_file
    file_url = 'http://api.todoist.com/file.jpg'
    stub_request(:delete, Todoist::Config::URLS[:delete_file].gsub(':file_url', file_url))
      .to_return_json(status: 200, body: 'ok'.to_json) # TODO: using to_json is bad practice.
    response = @client.file.delete(file_url: file_url)

    assert_equal true, response
  end

  def test_upload_file
    stub_request(:post, Todoist::Config::URLS[:upload_file])
      .to_return(status: 200, body: File.read('test/fixtures/upload.json'))

    file = @client.file.add(file_path: 'test/fixtures/image.jpg')
    assert_instance_of Todoist::Entities::File, file
    assert_equal file.file_name, 'image.jpg'
  end
end

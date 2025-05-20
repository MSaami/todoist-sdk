require 'test_helper'

class CommentResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_add_comment
    stub_request(:post, Todoist::Config::URLS[:comment])
      .to_return(status: 200, body: File.read('test/fixtures/comment.json'))

    comment = @client.comment.add(content: 'Note', project_id: 'test_project_id')
    assert_instance_of Todoist::Entities::Comment, comment
    assert_equal comment.content, 'Note'
  end

  def test_list_comment
    stub_request(:get, Todoist::Config::URLS[:comment])
      .with(query: { project_id: 'test_project_id' })
      .to_return(status: 200, body: File.read('test/fixtures/comments.json'))

    comments = @client.comment.all(project_id: 'test_project_id')
    assert_instance_of Todoist::Collection, comments
    assert_instance_of Todoist::Entities::Comment, comments.data.first
    assert_equal comments.count, 2
  end

  def test_add_comment_validation
    assert_raises(Todoist::Error) do
      @client.comment.add(content: 'Note')
    end
  end

  def test_list_comment_validation
    assert_raises(Todoist::Error) do
      @client.comment.all
    end
  end

  def test_update_comment
    stub_request(:post, Todoist::Config::URLS[:update_comment].gsub(':comment_id', 'test_comment_id'))
      .to_return(status: 200, body: File.read('test/fixtures/comment.json'))

    comment = @client.comment.update(id: 'test_comment_id', content: 'Note')
    assert_instance_of Todoist::Entities::Comment, comment
    assert_equal comment.content, 'Note'
  end

  def test_delete_comment
    stub_request(:delete, Todoist::Config::URLS[:delete_comment]
      .gsub(':comment_id', 'test_comment_id'))
      .to_return(status: 204)

    assert @client.comment.delete(id: 'test_comment_id')
  end

  def test_retrieve_comment
    stub_request(:get, Todoist::Config::URLS[:get_comment].gsub(':comment_id', 'test_comment_id'))
      .to_return(status: 200, body: File.read('test/fixtures/comment.json'))

    comment = @client.comment.retrieve(id: 'test_comment_id')
    assert_instance_of Todoist::Entities::Comment, comment
    assert_equal comment.content, 'Note'
  end
end

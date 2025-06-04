require 'test_helper'

class TaskResrouceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_add_task
    stub_request(:post, Todoist::Config::URLS[:task])
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.add('Test Task')
    assert_equal 'Test Task', task.content
  end

  def test_list_task
    stub_request(:get, Todoist::Config::URLS[:task])
      .to_return(status: 200, body: File.read('test/fixtures/tasks.json'))

    tasks = @client.task.list

    assert_instance_of Todoist::Collection, tasks
    assert_equal 2, tasks.count
  end

  def test_update_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:post, Todoist::Config::URLS[:update_task].gsub(':task_id', task_id))
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.update(task_id, content: 'Test Task')
    assert_equal 'Test Task', task.content
  end

  def test_delete_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:delete, Todoist::Config::URLS[:delete_task].gsub(':task_id', task_id))
      .to_return(status: 204)

    assert @client.task.delete(task_id)
  end

  def test_retrieve_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:get, Todoist::Config::URLS[:get_task].gsub(':task_id', task_id))
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.retrieve(task_id)
    assert_equal 'Test Task', task.content
  end
end

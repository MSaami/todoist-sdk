require 'test_helper'

class TaskResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_add_task
    stub_request(:post, Todoist::Config::URLS[:task])
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.add(content: 'Test Task')
    assert_equal 'Test Task', task.content
  end

  def test_all_task
    stub_request(:get, Todoist::Config::URLS[:task])
      .to_return(status: 200, body: File.read('test/fixtures/tasks.json'))

    tasks = @client.task.all

    assert_instance_of Todoist::Collection, tasks
    assert_equal 2, tasks.count
  end

  def test_update_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:post, Todoist::Config::URLS[:update_task].gsub(':task_id', task_id))
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.update(task_id: task_id, content: 'Test Task')
    assert_equal 'Test Task', task.content
  end

  def test_delete_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:delete, Todoist::Config::URLS[:delete_task].gsub(':task_id', task_id))
      .to_return(status: 204)

    assert @client.task.delete(task_id: task_id)
  end

  def test_retrieve_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:get, Todoist::Config::URLS[:get_task].gsub(':task_id', task_id))
      .to_return(status: 200, body: File.read('test/fixtures/task.json'))

    task = @client.task.retrieve(task_id: task_id)
    assert_equal 'Test Task', task.content
  end

  def test_search_task
    stub_request(:get, Todoist::Config::URLS[:search_task] + '?query=search: test')
      .to_return(status: 200, body: File.read('test/fixtures/tasks.json'))

    tasks = @client.task.search(query: 'search: test')
    assert_equal 2, tasks.count
  end

  def test_complete_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:post, Todoist::Config::URLS[:complete_task].gsub(':task_id', task_id))
      .to_return(status: 204)

    assert @client.task.complete(task_id: task_id)
  end

  def test_uncomplete_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:post, Todoist::Config::URLS[:uncomplete_task].gsub(':task_id', task_id))
      .to_return(status: 204)

    assert @client.task.uncomplete(task_id: task_id)
  end

  def test_move_task
    task_id = '6X7rM8997g3RQmvh'
    stub_request(:post, Todoist::Config::URLS[:move_task].gsub(':task_id', task_id))
      .to_return(status: 204)

    assert @client.task.move(task_id: task_id, project_id: '1234567890')
  end


  def test_completed_by_completion_date
    stub_request(:get, Todoist::Config::URLS[:completed_by_date] + '?since=2025-06-01&until=2025-06-31')
      .to_return(status: 200, body: File.read('test/fixtures/completed-tasks.json'))

    tasks = @client.task.completed_by_completion_date(from: '2025-06-01', to: '2025-06-31')
    assert_equal 2, tasks.count
  end

  def test_completed_by_due_date
    stub_request(:get, Todoist::Config::URLS[:completed_by_due_date] + '?since=2025-06-01&until=2025-06-31')
      .to_return(status: 200, body: File.read('test/fixtures/completed-tasks.json'))

    tasks = @client.task.completed_by_due_date(from: '2025-06-01', to: '2025-06-31')
    assert_equal 2, tasks.count
  end


end

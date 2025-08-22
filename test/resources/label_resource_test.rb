require 'test_helper'

class LabelResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_all_labels
    stub_request(:get, Todoist::Config::URLS[:labels])
      .to_return(status: 200, body: File.read('test/fixtures/labels.json'))

    labels = @client.label.all
    assert_instance_of Todoist::Collection, labels
    assert_equal 3, labels.count

    label = labels.first
    assert_instance_of Todoist::Entities::Label, label
    assert_equal 'Food', label.name
  end

  def test_add_label
    stub_request(:post, Todoist::Config::URLS[:labels])
      .to_return(status: 200, body: File.read('test/fixtures/label.json'))

    label = @client.label.add(name: 'Test Label')
    assert_instance_of Todoist::Entities::Label, label
    assert_equal 'Food', label.name
  end

  def test_delete_label
    label_id = '1234567890'
    stub_request(:delete, Todoist::Config::URLS[:delete_label].gsub(':label_id', label_id))
      .to_return(status: 204)

    assert @client.label.delete(id: label_id)
  end

  def test_update_label
    label_id = '1234567890'
    stub_request(:post, Todoist::Config::URLS[:update_label].gsub(':label_id', label_id))
      .to_return(status: 200, body: File.read('test/fixtures/label.json'))

    label = @client.label.update(id: label_id, name: 'Updated Label')
    assert_instance_of Todoist::Entities::Label, label
    assert_equal 'Food', label.name
  end

  def test_retrieve_label
    label_id = '1234567890'
    stub_request(:get, Todoist::Config::URLS[:get_label].gsub(':label_id', label_id))
      .to_return(status: 200, body: File.read('test/fixtures/label.json'))

    label = @client.label.retrieve(id: label_id)
    assert_instance_of Todoist::Entities::Label, label
    assert_equal 'Food', label.name
  end
end

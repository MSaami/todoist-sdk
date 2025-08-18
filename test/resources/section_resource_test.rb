require 'test_helper'

class SectionResourceTest < Minitest::Test
  def setup
    @client = Todoist::Client.new('test_token')
  end

  def test_add_section
    stub_request(:post, Todoist::Config::URLS[:section])
      .to_return(status: 200, body: File.read('test/fixtures/section.json'))

    section = @client.section.add(name: 'Groceries', project_id: '9Bw8VQXxpwv56ZY2')
    assert_equal 'Groceries', section.name
  end

  def test_all_section
    stub_request(:get, Todoist::Config::URLS[:section])
      .to_return(status: 200, body: File.read('test/fixtures/sections.json'))

    sections = @client.section.all
    assert_instance_of Todoist::Collection, sections
    assert_equal 2, sections.count
  end

  def test_retrieve_section
    stub_request(:get, Todoist::Config::URLS[:get_section].gsub(':section_id', '6Jf8VQXxpwv56VQ7'))
      .to_return(status: 200, body: File.read('test/fixtures/section.json'))

    section = @client.section.retrieve(id: '6Jf8VQXxpwv56VQ7')
    assert_equal 'Groceries', section.name
  end

  def test_update_section
    stub_request(:post, Todoist::Config::URLS[:update_section].gsub(':section_id', '6Jf8VQXxpwv56VQ7'))
      .to_return(status: 200, body: File.read('test/fixtures/section.json'))

    section = @client.section.update(id: '6Jf8VQXxpwv56VQ7', name: 'Groceries 2')
    assert_instance_of Todoist::Entities::Section, section
  end

  def test_delete_section
    stub_request(:delete, Todoist::Config::URLS[:delete_section].gsub(':section_id', '6Jf8VQXxpwv56VQ7'))
      .to_return(status: 204)

    assert @client.section.delete(id: '6Jf8VQXxpwv56VQ7')
  end
end
require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase
  test "resolver returns a template with the saved body" do
    resolver = SqlTemplate::Resolver.instance
    details = { :formats => [:html], :locale =>[:en], :handlers => [:erb]}
    
    # Assert our resolver cannot find any template as the database is empty
    # find_all(name, prefix, partial, details)
    assert resolver.find_all("index", "posts", false, details).empty?
    
    # Create a template in the database
    SqlTemplate.create!(
      :body => "<%= 'Hi from SqlTemplate!' %>",
      :path => "posts/index",
      :format => "html",
      :locale => "en",
      :handler => "erb",
      :partial => false
    )
    
    # Assert that a template can now be found
    template = resolver.find_all("index", "posts", false, details).first
    assert_kind_of ActionView::Template, template
    
    # Assert specific information about the found template
    assert_equal "<%= 'Hi from SqlTemplate!' %>", template.source
    assert_match /SqlTemplate - \d+ - "posts\/index"/, template.identifier
    assert_equal ActionView::Template::Handlers::ERB, template.handler
    assert_equal [:html], template.formats
    assert_equal "posts/index", template.virtual_path
  end
  
  test "sql_template expires the cache on update" do
    cache_key = Object.new
    resolver = SqlTemplate::Resolver.instance
    details = { :formats => [:html], :locale => [:en], :handlers => [:erb] }
    
    t = resolver.find_all("index", "users", false, details, cache_key).first
    assert_match /Users/, t.source
    
    sql_template = sql_templates(:one)
    sql_template.update_attributes(:body => "New body for template")
    
    t = resolver.find_all("index", "users", false, details, cache_key).first
    assert_equal "New body for template", t.source
  end
end

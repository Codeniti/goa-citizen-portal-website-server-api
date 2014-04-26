ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  # Add more helper methods to be used by all tests here...
  def get(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "GET")
  end

  # Executes a request simulating POST HTTP method and set/volley the response
  def post(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "POST")
  end

  # Executes a request simulating PUT HTTP method and set/volley the response
  def put(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "PUT")
  end

  # Executes a request simulating DELETE HTTP method and set/volley the response
  def delete(action, parameters = nil, session = nil, flash = nil)
    process_action(action, parameters, session, flash, "DELETE")
  end

  private
  def process_action(action, parameters = nil, session = nil, flash = nil, method = "GET")
    parameters ||= {}
    process(action, parameters.merge!(:use_route => @engine), session, flash, method)
  end
end

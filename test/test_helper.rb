ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def auth_headers(user)
    { "Authorization" => "Bearer #{AuthToken.encode(user)}" }
  end

  def admin_headers
    auth_headers(users(:admin))
  end
end

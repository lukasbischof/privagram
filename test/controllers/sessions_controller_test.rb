require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def test_login
    get '/login'
    assert_equal 200, status
  end
end

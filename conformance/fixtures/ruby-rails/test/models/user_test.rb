require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "invalid without email" do
    user = User.new
    assert_not user.valid?
  end
end

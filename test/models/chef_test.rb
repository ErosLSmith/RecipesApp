require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
  	@chef = Chef.new(chefname: "Eros", email: "eros@awesome.com")
  end
  
  test "chef should be valid" do
  	assert @chef.valid?
  end
  
  test "chef should have name" do
  	@chef.chefname = ""
  	assert_not @chef.valid?
  end
  
  test "email should be present" do
  	@chef.email = ""
  	assert_not @chef.valid?
  end
  
  test "email length max" do
  	@chef.email = "a" * 101
  end
  
  test "email minimun max" do
  	@chef.email = "a" * 4
  end

end

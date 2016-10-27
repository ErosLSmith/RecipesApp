require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "eros", email:"email@place.com")
  	@recipe = Recipe.new(name: "chicken parm",summary: "good stuff yeah",
  		description: "don't try this at home")
    @recipe.chef_id = chef.id

  end
  
  test "recipe should be valid" do
  	assert @recipe.valid?
  end
  
  test "recipe should have name" do
  	@recipe.name = ""
  	assert_not @recipe.valid?
  end
  
  test "summary should be present" do
  	@recipe.summary = ""
  	assert_not @recipe.valid?
  end
  
  test "summary length max" do
  	@recipe.summary = "a" * 101
  end
  
  test "summary minimun max" do
  	@recipe.summary = "a" * 4
  end

  test "description should be present" do
  	@recipe.description = ""
  	assert_not @recipe.valid?
  end
  
  test "description length max" do
  	@recipe.description = "a" * 101
  end
  
  test "description minimun max" do
  	@recipe.description = "a" * 4
  end

  test "chef_id should be present" do
    @recipe.chef_id = nil 
    assert_not @recipe.valid?
  end
end

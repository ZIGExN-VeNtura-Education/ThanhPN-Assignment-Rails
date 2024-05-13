require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Cannot save invalid category" do
    category = Category.new(title: '')
    # assert true
    assert_not category.save
  end

  test "Save valid category" do
    category = Category.new(title: 'Test category', color: 'default')
    assert category.save
  end
end

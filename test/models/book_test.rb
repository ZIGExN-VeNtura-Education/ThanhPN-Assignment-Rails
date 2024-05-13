require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  test "Cannot save invalid book" do
    book = Book.new(title: "", status: :draft, content: "")
    assert_not book.save
  end

  test "Save valid book" do
    book = Book.new(title: "Valid book", content: "Something")
    assert book.save
  end
end

class BookCategory < ApplicationRecord
  belongs_to :book, class_name: 'Book'
  belongs_to :category, class_name: 'Category'

  validates :category_id, presence: true
  validates :book_id, presence: true

end

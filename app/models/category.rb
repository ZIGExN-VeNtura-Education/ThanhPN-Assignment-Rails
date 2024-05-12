class Category < ApplicationRecord
  enum color: {
    default: 'default',
    blue: 'primary',
    green: 'success',
    light_blue: 'info',
    yellow: 'warning',
    red: 'danger'
  }
  has_many :book_relationship, class_name: 'BookCategory', foreign_key: 'category_id', dependent: :destroy
  has_many :books, through: :book_relationship, source: :book

  validates :title, presence: true

  def add_book(other_book)
    books << other_book
  end

  def remove_book(other_book)
    books.delete(other_book)
  end
end

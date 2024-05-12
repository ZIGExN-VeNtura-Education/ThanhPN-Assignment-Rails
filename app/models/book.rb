class Book < ApplicationRecord
  scope :published_book, -> { where(status: :published) }
  enum status: {
    draft: 0,
    published: 1
  }

  has_one_attached :image
  DEFAULT_IMAGE = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019"
  has_many :category_relation, class_name: 'BookCategory', foreign_key: :book_id, dependent: :destroy
  has_many :categories, through: :category_relation, source: :category

  validates :title, presence: true
  validates :content, presence: true
  def add_category(other_category)
    # puts self.categories
    self.categories << other_category
  end

  def remove_category(other_category)
    categories.delete(other_category)
  end

  def self.id(id)
    Category.find(id: id)
  end
end

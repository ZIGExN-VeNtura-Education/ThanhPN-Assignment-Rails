# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.new([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.new(name: 'Luke', movie: movies.first)

category1 = Category.create!(title: Faker::Book.genre)
category2 = Category.create!(title: Faker::Book.genre, color: Category.colors[:primary])

40.times do |n|
  title = Faker::Book.title
  content = Faker::ChuckNorris.fact

  book = Book.create!(
    title: title,
    content: content,
    # image: image,
    status: n % 2 == 0 ? :draft : :published
  )
  if n % 2 == 0
    book.image.attach(io: File.open('db/Seed_image_cover.jpg'), filename: 'cover.jpg')
  end
end

books = Book.all
books.each do |book|
  category_get_one = book.id % 2 == 0
  # category_get_two = book.id % 2 != 0
  category_get_both = book.id % 3 == 0
  if category_get_both
    book.add_category(category1)
    book.add_category(category2)
  elsif category_get_one
    book.add_category(category1)
  else
    book.add_category(category2)
  end
end

User.create!(
  email: "admin@email.com",
  password: 123456,
  password_confirmation: 123456,
  role: User.roles[:admin]
)

User.create!(
  email: "guest@email.com",
  password: 123456,
  password_confirmation: 123456,
  role: User.roles[:guest]
)

User.create!(
  email: "moderator@email.com",
  password: 123456,
  password_confirmation: 123456,
  role: User.roles[:moderator]
)

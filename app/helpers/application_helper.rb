module ApplicationHelper


  def default_book_image_tag(book, option ={})
    src = book.image.attached? ? book.image : Book::DEFAULT_IMAGE
    image_tag(src, option)
  end

  def manager_users?
    current_user.role != "guest"
  end

  def admin_users?
    current_user.role == "admin"
  end

  def admin_disabled_class
    "disabled" unless admin_users?
  end

  def manager_disabled_class
    "disabled" unless  manager_users?
  end
end

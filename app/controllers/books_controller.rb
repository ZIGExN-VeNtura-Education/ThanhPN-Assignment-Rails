class BooksController < ApplicationController
  before_action :already_logged_in?
  before_action :manager_users?, except: %i[show]

  # => khong tim thay book thi tra ve trang index voi flash
  def show
    id = params[:id]
    @book = Book.find_by(id: id)
    redirect_nil
  end

  def new
    @book = Book.new
    @categories_selected = nil
  end

  def create
    @book = Book.new(title: book_params[:title], content: book_params[:content], image: book_params[:image], status: book_params[:status])
    if @book.save
      categories = Category.where(id: book_params[:categories])
      @book.add_category categories
      flash[:success] = "Book created!"
      redirect_to @book
    else
      render 'books/new'
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
    redirect_nil
    @categories_selected = @book.categories.pluck(:id)
  end

  def update # => action chu khong phai instance method (trong rails)
    @book = Book.find(params[:id]) # @variable
    redirect_nil
    update_data = { title: book_params[:title], content: book_params[:content], image: book_params[:image], status: book_params[:status] }
    if @book.update(update_data)
      # remove old categories
      # TODO: The best is remove which is not in input and insert which is needed to insert
      # Example : Input [1,2,3], Current [2,4] => Remove 4 and insert 1 and 3
      @book.category_relation.destroy_all
      categories = Category.where(id: book_params[:categories])
      @book.add_category categories
      flash[:success] = "Book updated!"
      redirect_to @book
    else
      render 'books/edit'
    end
  end

  def destroy

    book = Book.find_by(id: params[:id])
    if book.destroy
      flash[:success] = "Deleted book"
    else
      flash[:danger] = "Cannot delete book!"
    end
    redirect_back(fallback_location: :fallback_location)

  end

  private

  def book_params
    params.require(:book).permit(:title, :content, :image, :status, categories: [])
  end

  def redirect_nil
    if @book.nil?
      flash[:danger] = "Cannot find book id"
      redirect_to root_url
    end
  end
end

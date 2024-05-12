class AdminsController < ApplicationController
  before_action :already_logged_in?
  before_action :manager_users?
  def show
    search = params[:search]
    query = Book
    query = query.where('title like ?', "%#{search}%") unless search.nil?
    @books = query.paginate(page: params[:page])
  end

  def create
    @book = Book.find_by(id: params[:id])
      # debugger
    if @book.nil?
      flash.now[:danger] = "Cannot update, cant find book"
    else
      @book.update(status: params[:value])
      flash.now[:success] = "Book is updated"
    end
    redirect_back(fallback_location: :fallback_location)
  end


end

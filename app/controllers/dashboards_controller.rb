class DashboardsController < ApplicationController
  def show
    search = params[:search]
    query = Book
    query = query.where('title like ?', "%#{search}%") unless search.nil?
    @books = query.paginate(page: params[:page], per_page: 6)
    # debugger
  end
end

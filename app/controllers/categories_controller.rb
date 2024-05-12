class CategoriesController < ApplicationController
  before_action :admin_users?, only: %i[new edit create update]
  before_action :manager_users?, except: %i[index show]
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(id: params[:id])
    redirect_when_404 @category
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by(id: params[:id])
    redirect_when_404 @category
  end

  def create
    @category = Category.new(category_param)
    if @category.save
      flash[:success] = "Saved"
      redirect_to @category
    else
      flash[:danger] = "Cannot save"
      render new
    end
  end

  def update
    @category = Category.find_by(id: params[:id])
    redirect_when_404 @category
    if @category.update(category_param)
      flash[:success] = "Updated"
      redirect_to @category
    else
      flash[:danger] = "Cannot save"
      render edit
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    redirect_when_404 @category
    if @category.destroy
      flash[:success] = "Deleted category"
      redirect_to categories_path
    else
      flash[:danger] = "Cannot save"
      redirect_back(fallback_location: :fallback_location)
    end
  end

  private

  def redirect_when_404(object)
    if object.nil?
      flash[:danger] = "Cannot find category"
      redirect_to root_url
    end
  end

  def category_param
    params[:category].permit(:title, :color)
  end
end
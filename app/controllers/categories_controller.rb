class CategoriesController < ApplicationController

  def index
    @allcategories = Category.all.order('categories.name')
  end
  
  def show 
    @restaurants_of_category = Category.all
  end
end

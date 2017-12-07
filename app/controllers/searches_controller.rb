class SearchesController < ApplicationController

  def search

    if params[:search]
      @categories = Category.search(params[:search]).order(:name)
      @systems = System.search(params[:search]).order(:name)
      @images = Image.search(params[:search]).order(:name)
    end

  end

end


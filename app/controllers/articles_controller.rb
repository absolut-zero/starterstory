class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.includes(:article_sections).find(params[:id])
  end
end

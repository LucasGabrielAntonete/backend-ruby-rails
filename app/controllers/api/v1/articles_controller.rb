class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article 
      render json: article, status: 200
    else
      render json: {
        error: "Article not found"
      }

    end
  end

  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 200
    else 
      render json: { errors: "error in creating article" }, status: 400
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article.update(arti_params)
      render json: "article update sucess", status: 200
    else
      render json: { errors: "error in updating article" }, status: 400
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article.destroy
      render json: "article deleted sucess", status: 200
    else
      render json: { errors: "error in deleting article" }, status: 400
    end
  end
  
  private
  def arti_params
    params.require(:article).permit([:title, :body, :author])
  end
end

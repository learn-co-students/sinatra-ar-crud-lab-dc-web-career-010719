
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    @article = Article.create(title: params[:article][:title], content: params[:article][:content])
    redirect "/articles/#{@article.id}"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.all.find(id)
    erb :show
  end

  delete '/articles/:id' do
    id = params[:id]
    Article.destroy(id)
    redirect '/articles'
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.all.find(id)
    erb :edit
  end

  patch '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    @article.title = params[:article][:title]
    @article.content = params[:article][:content]
    @article.save
    redirect "/articles/#{@article.id}"
  end

end

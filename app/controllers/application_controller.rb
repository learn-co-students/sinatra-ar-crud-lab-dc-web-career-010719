
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    redirect '/articles'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  post '/articles' do
    title = params[:title]
    content = params[:content]
    @article = Article.create(title: title, content: content)
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end

  patch '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect 'articles'
  end


end

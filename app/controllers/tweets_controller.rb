class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @user = current_user

    if !params[:content].empty?
      @user.tweets << Tweet.create(params)
      redirect "/tweets"
    else
      redirect 'tweets/new'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.all.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.all.find_by_id(params[:id])
    redirect "/tweets/#{@tweet.id}/edit"
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.all.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.all.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.destroy
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

end

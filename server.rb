require 'sinatra'
require 'csv'

get '/articles' do
  @articles = CSV.read('news_aggregator.csv', headers: true, header_converters: :symbol)
  erb :index
end

get '/articles/new' do
  erb :show
end

post '/articles/new' do
  title = params[:title]
  url = params[:url]
  description = params[:description]
  CSV.open('news_aggregator.csv', 'a') do |csv|
    csv << [title,url,description]
    erb :show
  end

  redirect '/articles'
end

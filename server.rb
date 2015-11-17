require 'sinatra'
require 'csv'
require'pry'

enable :sessions

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
  @articles = CSV.read('news_aggregator.csv', headers: true, header_converters: :symbol)
    if @articles.any? {|article| article[:url] == url}
      redirect '/articles/new'
    else
      CSV.open('news_aggregator.csv', 'a') do |csv|
        csv << [title,url,description]
        erb :show
      end
    end
  redirect '/articles'
end

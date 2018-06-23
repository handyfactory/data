require 'sinatra'
require 'data_mapper'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :major, String
  property :year, String
  property :phone_number, String
  property :email, String
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!
Member.auto_upgrade!

get '/' do
    @posts = []
    
    @posts = Post.all
    
    # CSV.foreach("board.csv") do |row|
    #     @posts << row 
    # end
    
    erb :index
end

get '/create' do
    @title = params[:title]
    @content = params[:content]
    
    Post.create(
        title: @title,
        body: @content
    )
    
    # CSV.open('board.csv', 'a+') do |csv|
    #     csv << [@title, @content]
    # end
    
    redirect '/'
end

get '/resister' do
    erb :resister
end

get '/signup' do
    @name = params[:name]
    @major = params[:major]
    @year = params[:year]
    @phone = params[:phone_number]
    @email = params[:email]
    
    Member.create(
        name: @name,
        major: @major,
        year: @year,
        phone_number: @phone,
        email: @email
            
        end
        
        )
    
    redirect '/resister'
end
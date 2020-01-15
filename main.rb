require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'yaml'

before do
  @users = YAML.load_file("users.yaml")
end

helpers do
  def count_interests
    interests = 0
    @users.each do |user, details|
      interests += @users[user][:interests].size
    end

    interests
  end
end

get "/sandbox" do
  @users.inspect
end

get "/" do
  @users = @users
  erb(:index)
end

get "/users/:name" do
  @name = params[:name]
  @email = @users[@name.to_sym][:email]
  @interests = @users[@name.to_sym][:interests].join(', ')

  erb(:show)
end

require 'rubygems'
require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
:adapter  => "mysql2",
:host     => "localhost",
# :username => "user",
# :password => "password",
:database => "rolling"
)

class User < ActiveRecord::Base
end

class App < Sinatra::Application
end

get '/' do
  users = User.all

  x= "<h1>Hello #{users.size} users</h1>"
  users.each do |user|
    x += "<p>#{user.name}</p>"
  end
  x
end

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
  has_many :addresses, dependent: :destroy
end

class Address < ActiveRecord::Base
  belongs_to :user
end

class App < Sinatra::Application
end

get '/' do
  users = User.all

  x= "<h1>Hello #{users.size} users V2</h1>"
  users.each do |user|
    x += "<p>#{user.username}</p>"
    user.addresses.each do |address|
      x += "<p> address #{address.address_line_1} #{address.address_line_2}</p>"
    end
  end
  x
end

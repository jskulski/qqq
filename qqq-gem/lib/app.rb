require 'rubygems'
require 'sinatra'
require 'active_record'

def init_db
  puts 'init_db'
  ActiveRecord::Base.establish_connection(
    :adapter  => "mysql2",
    :host     => "localhost",
    :username => "root",
    :password => "",
    :database => "qqq"
  )
end

def create_db
  ActiveRecord::Migration.create_table :messages do |t|
    t.string :uuid
    t.string :message
    t.datetime :recorded_at
    t.datetime :created_at

    t.index :uuid
    t.index :message
    t.index :recorded_at
    t.index :created_at
  end
end

def destroy_db
  ActiveRecord::Migration.drop_table :messages
end

init_db
destroy_db
create_db

class Message < ActiveRecord::Base
end

class App < Sinatra::Application
end

get '/' do
  messages = Message.all.order(id: :desc)
  return messages.map { |m| "#{m.message}<hr>"}
end

post'/message' do
  puts "Server received message"
  Message.create(message: params['message'])
  puts Message.count
end



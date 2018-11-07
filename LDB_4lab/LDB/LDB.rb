require 'sqlite3'
require 'active_record'
require_relative 'project'
require_relative 'user'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :projects do |t|
    t.string :name
  end
  create_table :users do |t|
    t.string :name
  end
end

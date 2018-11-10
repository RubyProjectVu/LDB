require 'sqlite3'
require 'active_record'
require_relative 'project'
require_relative 'user'
require_relative 'project_member'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: './dbfile'
)

ActiveRecord::Schema.define do
  if !['projects', 'users'].all? { |i| ActiveRecord::Base.connection.tables.include? i }
    create_table :projects do |t|
      t.string :name
      t.string :manager
      t.string :status

    end

    create_table :project_members do |t|
      t.integer :projid
      t.string :member
    end
    
    create_table :users do |t|
      t.string :name
    end
  end
end

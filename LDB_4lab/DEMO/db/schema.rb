# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do
  # Holds all projects
    create_table :projects do |t|
      t.string :name
      t.string :manager
      t.string :status
    end

    # Holds a list of members under a project
    create_table :project_members do |t|
      t.integer :projid
      t.string :member
    end

    # Holds all users
    create_table :users do |t|
      t.string :name
    end
end

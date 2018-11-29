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
      t.float :budget
    end

    # Holds a list of members under a project
    create_table :project_members do |t|
      t.integer :projid
      t.string :member
    end

    # Holds all users
    create_table :users do |t|
      t.string :name
      t.string :lname
      t.string :email, null: false, index: { unique: true }
      t.string :pass
    end

    # Holds notes made by users
    create_table :notes_managers do |t|
      t.string :name
      t.string :author
      t.text :text
      t.datetime :expire
    end

    # Holds all tasks
    create_table :tasks do |t|
      t.string :task
    end

    # Holds all workgroups
    create_table :work_groups do |t|
      t.integer :projid
      t.string :name
      t.float :budget
    end

    # Holds a list of members under a workgroup
    create_table :work_group_members do |t|
      t.integer :wgid
      t.string :member
    end

    # Holds a list of tasks under a workgroup
    create_table :work_group_tasks do |t|
      t.integer :wgid
      t.integer :task
    end

    # Holds all roles
    # Role individual levels should be described on separate yml
    create_table :roles do |t|
      t.integer :usrid
      t.string :role
    end
end

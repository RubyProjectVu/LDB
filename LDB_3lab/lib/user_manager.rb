# frozen_string_literal: true

require_relative 'project_manager'
require 'yaml'

# class defining user management
class UserManager
  def initialize
    load_file
    @users = {} if @users.equal?(false)
    @current_user = {}
  end

  def load_file
    @users = YAML.load_file('users.yml')
  end

  def current_user_getter
    @current_user
  end

  def to_hash(email)
    { email => @users.fetch(email) }
  end

  def register(user)
    @current_user = user.user_info

    mailing = @current_user.fetch('email'.to_sym)
    hash = { mailing => { 'name' => @current_user.fetch('name'.to_sym),
                          'lname' => @current_user.fetch('lname'.to_sym),
                          'pwd' => @current_user.fetch('pass'.to_sym) } }
    return true if users_push(mailing, hash)

    false
  end

  def login(user_to_login)
    email = user_to_login.data_getter('email')
    return true unless [nil].include?(@users[email])

    false
  end

  def delete_user(user)
    users_pop(user.data_getter('email'))
  end

  def users_push(email, hash)
    return false unless [nil].include?(@users[email])

    File.open('users.yml', 'a') do |fl|
      fl.write hash.to_yaml.sub('---', '')
    end

    load_file
    true
  end

  def users_pop(email)
    @users.delete(email)
    File.open('users.yml', 'w') do |fl|
      fl.write @users.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end

  def save_user_password(user_email, password)
    puts "user_mail = #{user_email}"
    hash = to_hash(user_email)
    usr = User.new(name: hash[user_email].fetch('name'),
                   last_name: hash[user_email].fetch('lname'),
                   email: user_email,
                   pass: password)
    users_pop(user_email)
    users_push(usr, usr.to_hash)
  end
end

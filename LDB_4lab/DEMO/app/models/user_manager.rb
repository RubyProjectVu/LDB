# frozen_string_literal: true

require_relative 'project_manager'
require 'yaml'

# class defining user management
class UserManager
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
    return true unless [nil].include?(@users[user_to_login])

    false
  end

  def delete_user(user)
    users_pop(user.data_getter('email'))
  end

  # TODO: active project checking will be implemented later

  def users_push(email, hash)
    return false unless [nil].include?(@users[email])

    File.open('users.yml', 'a') do |fl|
      fl.write hash.to_yaml.sub('---', '')
    end
    true
  end

  def users_pop(email)
    @users.delete(email)
    File.open('users.yml', 'w') do |fl|
      fl.write @users.to_yaml.sub('---', '').sub('{}', '')
    end
    true
  end
end

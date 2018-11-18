# frozen_string_literal: true

require_relative 'user'
require './application_record'
require 'yaml'

# class defining user management
class UserManager
  def register(name, lname, email, pass)
    user = User.find_by(email: email)
    return false if user
    User.create(name: name, lname: lname, email: email, pass: pass)

    true
  end

  def login(email, pass)
    return false if [nil].include?(User.find_by(email: email))
    return false unless User.find_by(email: email).pass.match?(pass)

    true
  end

  def delete_user(email)
    user = User.find_by(email: email)
    return false unless user
    user.destroy
    true
  end

  # TODO: active project checking will be implemented later
end

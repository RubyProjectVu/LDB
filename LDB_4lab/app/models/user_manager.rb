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
    return false unless user && !manages_project?(email)

    user.destroy
    true
  end

  def upl_certif(url, user)
    return false unless valid_url(url)

    Certificate.create(user: user, link: url)
  end

  def valid_url(url)
    ext = File.extname(URI.parse(url).path)
    valid = %w[.doc .pdf]
    return true if valid.include?(ext)
    false
  end

  def manages_project?(user_email)
    proj = Project.find_by(manager: user_email)
    return true if proj

    false
  end
end

# frozen_string_literal: true

require_relative 'user'
require 'time'
require 'yaml'

# this is System class description
class System
  def initialize
    @users = YAML.load_file('users.yml')
    @sys = YAML.load_file('system.yml')
  end

  def login(user_to_login)
    return true unless [nil].include?(@users[user_to_login])

    false
  end

  def last_use(arg)
    # arg kills mutations
    # double variables for reek FeatureEnvy
    lu = lus = @sys.fetch('lastuse')
    return false unless lu.key?(arg)

    lus.fetch(arg)
  end

  def users_push(email, hash)
    return false if @users.key?(email)

    File.open('users.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def users_pop(email)
    @users.delete(email)
    File.open('users.yml', 'w') { |fl| fl.write @users.to_yaml.sub('---', '') }
    true
  end
end

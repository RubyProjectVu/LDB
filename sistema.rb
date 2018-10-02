require_relative 'vartotojas'
require 'time'

# Documentation
class Sistema
  attr_reader :logged_in_users

  def initialize
    @logged_in_users = [] # Array.new
  end

  def user_input_validation(user)
    validate = true
    if !user.name.match(/[a-zA-Z][a-z]+/)
      validate = false
    elsif !user.last_name.match(/[a-zA-Z][a-z]+/)
      validate = false
    elsif !user.email.match(/[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.][a-zA-Z]+/)
      validate = false
    end
    validate
  end

  def register(user_to_register)
    if File.file?('users.txt')
      File.foreach('users.txt', 'r') do |line|
        users = line.split(';')
        users.each do |user|
          user_data = user.split(',')
          return false if user_data[2].match(user_to_register.email)
        end
      end
    end
    # save_registered_user(user_to_register)
    true
  end

  def save_registered_user(user_to_register)
    user_to_register.unique_id_setter
    File.open('users.txt', 'a') do |reg|
      output_string = "#{user_to_register.name},#{user_to_register.last_name}"
      output_string += ",#{user_to_register.email},#{user_to_register.user_id}"
      reg.puts ";#{output_string}"
      reg.close
    end
  end

  def login(user_to_login)
    if File.file?('users.txt')
      File.foreach('users.txt', 'r') do |line|
        return true if construct_user(line.split(';'), user_to_login)
      end
    end
    false
  end

  def construct_user(line, user_to_login)
    line.each do |user|
      user_data = user.split(',')
      new_user = Vartotojas.new(name: user_data[0], last_name: user_data[1],
                                email: user_data[2])
      new_user.unique_id_setter(user_data[3])
      return try_logging_in(new_user, user_to_login)
    end
    false
  end

  def try_logging_in(new_user, user_to_login)
    if new_user.equals(user_to_login)
      unless @logged_in_users.include? user_to_login
        @logged_in_users.push(user_to_login)
        true
      end
    end
  end

  def logout(user_to_logout)
    @logged_in_users.delete(user_to_logout)
  end

  def log_user_login_logout(name, last_name, logs_in = true)
    File.open('syslog.txt', 'a') do |log|
      if logs_in
        log.puts "User: #{name} #{last_name} logs in at #{Time.now.getutc}."
      else
        log.puts "User: #{name} #{last_name} logs out at #{Time.now.getutc}."
      end
    end
  end

  def log_project_creation(name, user)
    File.open('syslog.txt', 'a') do |log|
      v1 = user.unique_id_getter
      v2 = Time.now.getutc
      log.puts "Project: #{name} created by #{v1} at #{v2}."
    end
  end

  def log_password_request(name, last_name, email)
    File.open('syslog.txt', 'a') do |log|
      sho = [Time.now.getutc, name]
      # v1 = Time.now.getutc
      # n = name
      l = last_name
      log.puts "Pass req for user: #{sho[1]} #{l} to #{email} at #{sho[0]}."
    end
  end

  def log_certificate_upload(name, last_name, file)
    File.open('syslog.txt', 'a') do |log|
      v1 = Time.now.getutc
      n = name
      l = last_name
      f = file
      log.puts "User: #{n} #{l} uploaded a certification #{f} at #{v1}."
    end
  end

  def latest_entry
    File.readlines('syslog.txt').last
    # lines.last
  end
end

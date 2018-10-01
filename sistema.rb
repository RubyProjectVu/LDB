require_relative 'vartotojas'
require 'time'

# Documentation
class Sistema
  attr_reader :logged_in_users

  def initialize
    @logged_in_users = [] # Array.new
  end
  
  def user_input_validation(user)
	  validate = true;
    if !user.name.match(/[a-zA-Z][a-z]+/ )
      validate = false
    elsif !user.last_name.match(/[a-zA-Z][a-z]+/ )
      validate = false
    elsif !user.email.match(/[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.][a-zA-Z]+/ )
      validate = false
    end
		
    validate
  end
	
  def register(user_to_register)
    if ( File.file?("users.txt") )
      File.foreach("users.txt", "r") do |line|
        users = line.split(";")
        users.each do |user|
          user_data = user.split(",")
          if user_data[2].match(user_to_register.email)
            return false
          end
        end
      end
    end
    user_to_register.set_unique_id
    File.open("users.txt", "a") do |reg|
      reg.puts ";#{user_to_register.name},#{user_to_register.last_name},#{user_to_register.email},#{user_to_register.user_id}"
      reg.close
    end
    true
  end

  def login(user_to_login)
    if File.file?('users.txt')
      File.foreach('users.txt', 'r') do |line|
        users = line.split(';')
        users.each do |user|
          user_data = user.split(',')
          new_user = Vartotojas.new(name: user_data[0],
                                    last_name: user_data[1],
                                    email: user_data[2])
          new_user.set_unique_id(user_data[3])

          if new_user.equals(user_to_login)
            unless @logged_in_users.include? user_to_login
              @logged_in_users.push(user_to_login)
              return true
            end
          end
        end
      end
      # false
    else
      false
    end
    false
  end

  def logout(user_to_logout)
    @logged_in_users.delete(user_to_logout)
  end

  def log_user_login_logout(name, last_name, logs_in = true)
    if logs_in
      File.open('syslog.txt', 'a') do |log|
        log.puts "User: #{name} #{last_name} logged in at #{Time.now.getutc}."
      end
    else
      File.open('syslog.txt', 'a') do |log|
        log.puts "User: #{name} #{last_name} logged out at #{Time.now.getutc}."
      end
    end
  end

  def log_project_creation(name, user)
    File.open('syslog.txt', 'a') do |log|
      v1 = user.get_unique_id
      v2 = Time.now.getutc
      log.puts "Project: #{name} created by #{v1} at #{v2}."
    end
  end

  def log_password_request(name, last_name, email)
    File.open('syslog.txt', 'a') do |log|
      v1 = Time.now.getutc
      n = name
      l = last_name
      log.puts "Password request for user: #{n} #{l} to #{email} at #{v1}."
    end
  end
  
  def log_certificate_upload(name, last_name, file)
    File.open('syslog.txt', 'a') do |log|
      v1 = Time.now.getutc
      n = name
      l = last_name
      f = file
      log.puts "User: #{n} #{l} uploaded a certification #{f}."
    end
  end

  def latest_entry
    lines = File.readlines('syslog.txt')
    lines.last
  end
end

require 'time'

# Some docs here
class SystemUserLogger
  attr_reader :system_file
  # [0] - user name
  # [1] - user last name
  # [2] - user id
  # [3] - email
  # [4] - certification
  attr_reader :latest_user_info

  def initialize(info)
    @latest_user_info = info
    @system_file = 'syslog.txt'
  end

  def latest_entry
    File.readlines(@system_file).last
  end

  def log_user_login
    time = Time.now.getutc
    File.open(@system_file, 'a') do |log|
      log.puts "User: #{latest_user_info[0]} " \
               "#{latest_user_info[1]} logs in at " \
               "#{time}."
    end
  end

  def log_user_logout
    time = Time.now.getutc
    File.open(@system_file, 'a') do |log|
      log.puts "User: #{latest_user_info[0]} " \
               "#{latest_user_info[1]} logs out at " \
               "#{time}."
    end
  end

  def log_password_request
    time = Time.now.getutc
    File.open(@system_file, 'a') do |log|
      log.puts "Password request for user: #{latest_user_info[2]}" \
               "to #{latest_user_info[3]} at #{time}"
    end
  end

  def log_certificate_upload
    time = Time.now.getutc
    File.open(@system_file, 'a') do |log|
      log.puts "User: #{latest_user_info[0]} " \
               "#{latest_user_info[1]} uploaded a certification " \
               "#{latest_user_info[4]} at #{time}"
    end
    true
  end
end

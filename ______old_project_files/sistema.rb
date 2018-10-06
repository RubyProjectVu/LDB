require_relative 'vartotojas'
require 'time'

# this is sistema class description
class Sistema
  attr_reader :logged_in_users
  attr_reader :state

  def initialize
    @logged_in_users = [] # Array.new
    @state = true
  end

  def user_input_validation(user)
    validate = true
    if !user.name.match(/[a-zA-Z][a-z]+/)
      # validate = false
    elsif !user.last_name.match(/[a-zA-Z][a-z]+/)
      # validate = false
    elsif !user.email.match(/[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.][a-zA-Z]+/)
      validate = false
    end
    validate
  end

  def register(user_to_register)
    if File.file?('users.txt')
      user_file = File.read('users.txt')
      users = user_file.split(';')
      users.each do |user|
        user_data = user.split(',')
        return false if user_data[2].match(user_to_register.email)
      end
    end
    # save_registered_user(user_to_register)
    true
  end

  # def save_registered_user(user_to_register)
  #  user_to_register.unique_id_setter
  #  File.open('users.txt', 'a') do |reg|
  #    output_string = "#{user_to_register.name}
  # ,#{user_to_register.last_name}"
  #    output_string += ",#{user_to_register.
  # email},#{user_to_register.user_id}"
  #    reg.puts ";#{output_string}"
  #    reg.close
  #  end
  # end

  def login(user_to_login)
    if File.file?('users.txt')
      user_file = File.read('users.txt')
      return true if construct_user(user_file.split(';'), user_to_login)
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

  # def log_project_creation(name, user)
  #  @state = true
  #  File.open('syslog.txt', 'a') do |log|
  #    user_id = user.unique_id_getter
  #    time_now = Time.now.getutc
  #    log.puts "Project: #{name} created by #{user_id} at #{time_now}."
  #  end
  # end

  def log_user_login_logout(name, last_name, logs_in = true)
    false if @state == false
    time = Time.now.getutc
    File.open('syslog.txt', 'a') do |log|
      if logs_in
        log.puts "User: #{name} #{last_name} logs in at #{time}."
      else
        log.puts "User: #{name} #{last_name} logs out at #{time}."
      end
    end
  end

  def log_password_request(name, last_name, email)
    false if @state == false
    File.open('syslog.txt', 'a') do |log|
      sho = [Time.now.getutc, name]
      interpolated_text = "#{sho[1]} #{last_name} to #{email} at #{sho[0]}."
      log.puts 'Pass req for user: ' + interpolated_text
    end
  end

  def log_certificate_upload(name, last_name, file)
    @state = true
    File.open('syslog.txt', 'a') do |log|
      time_now = Time.now.getutc
      certification_text = 'uploaded a certification '
      log_text = "User: #{name} #{last_name} "
      log_text += certification_text
      log_text += "#{file} at #{time_now}."

      log.puts log_text
    end
  end

  # def log_project_deletion(name, user)
  #  FFile.open('syslog.txt', 'a') do |log|
  #    log.puts "Project: #{name} del
  #  end
  # end

  def log_work_group_creation(name, user)
    @state = true
    File.open('syslog.txt', 'a') do |log|
      vv = user.unique_id_getter
      vd = Time.now.getutc
      log.puts "Work group: #{name} created by #{vv} at #{vd}."
    end
  end

  def log_work_group_deletion(name, user)
    false unless @state
    File.open('syslog.txt', 'a') do |log|
      vv = user.unique_id_getter
      vd = Time.now.getutc
      log.puts "Work group: #{name} deleted by #{vv} at #{vd}."
    end
  end

  def latest_entry
    File.readlines('syslog.txt').last
    # lines.last
  end
end

require_relative 'vartotojas'
require 'time'

class Sistema
	attr_reader :logged_in_users

	def initialize
		@logged_in_users = Array.new
	end

	def login(user_to_login)
		if(File.file?("users.txt"))
			File.foreach("users.txt", "r") do |line|
				users = line.split(";")
				users.each do |user|
					user_data = user.split(",")
					new_user = Vartotojas.new(name: user_data[0], last_name: user_data[1], email: user_data[2])
					new_user.set_unique_id(user_data[3])

					if new_user.equals(user_to_login)
						@logged_in_users.push(user_to_login)
						return true
					end
				end
			end
			return false
		else
			return false
		end
	end

	def logout(user_to_logout)
		return @logged_in_users.delete(user_to_logout)
	end
	
	def log_user_login_logout(name, last_name, logs_in = true)
		if logs_in
			File.open("syslog.txt", "a") do |log|
				log.puts "User: #{name} #{last_name} logged in at #{Time.now.getutc}."
			end
		else
			File.open("syslog.txt", "a") do |log|
				log.puts "User: #{name} #{last_name} logged out at #{Time.now.getutc}."
			end
		end
	end
	
	def log_project_creation(name, user)
		File.open("syslog.txt", "a") do |log|
			log.puts "Project: #{name} created by #{user.get_unique_id} at #{Time.now.getutc}."
		end
	end
	
	def log_password_request(name, last_name, email)
		File.open("syslog.txt", "a") do |log|
			log.puts "Password request for user: #{name} #{last_name} to #{email} at #{Time.now.getutc}."
		end
	end

	def get_latest_entry
		lines = File.readlines("syslog.txt")
		return lines.last
	end
	
end

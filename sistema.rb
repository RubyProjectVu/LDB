require 'D:\Aivaras\VU\IT\Ruby\LDB-Aivaras\vartotojas'
class Sistema
	attr_reader :logged_in_users
	
	def initialize
		@logged_in_users = Array.new
	end
	
	def login(user_to_log_in)
		if(File.file?("users.txt"))
			File.foreach("users.txt", "r") do |line| 
				users = line.split(";")
				users.each do |user|
					user_data = user.split(",")
					new_user = Vartotojas.new(user_data[0], user_data[1], user_data[2])
					new_user.set_unique_id(user_data[3])
					
					if new_user.equals(user_to_log_in)
						@logged_in_users.push(user_to_log_in)
						return true
					end
				end
			end
			return false
		else
			return false
		end
	end

end

u = Sistema.new
v= Vartotojas.new("q","w","t@a.com")
v.set_unique_id("17c1993f2ff2378e5bcbe8dd9f909c94")
puts u.login(v)


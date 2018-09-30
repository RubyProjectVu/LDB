require 'securerandom' #random hash kuriantis metodas yra

class Vartotojas
	attr_reader :name
	attr_reader :last_name
	attr_reader :email
	attr_reader	:gender
	attr_reader :user_id
	attr_reader :phone_number
	attr_reader :projects
	
	def initialize(name: "", last_name: "", email: "")
		@name = name
		@last_name = last_name
		@email = email
		@projects = {}
	end
	
	def set_unique_id(id = SecureRandom.hex)
		@user_id = id
	end
	
	def equals(other_user)
		if (@name == other_user.name and @last_name == other_user.last_name and @email == other_user.email and @user_id == other_user.user_id)
			return true
		end
		return false
	end
	
	def prepare_deletion
		active_projects = gather_active_projects
		if !active_projects.any?
			#should ideally mark userid as deleted on another entity {System}
			return true
		else	
			#should ideally contact project managers
			return false
		end
	end
	
	def gather_active_projects
		active_projects = []
		@projects.each {|name, status| 
				if status.eql? 'In progress' 
					active_projects << name
				end
			}
		return active_projects
	end
	
	def add_project(project, status)
		#should ideally determine if project manager approves first
		@projects[:project] = status
	end
	
	def change_project_status(project, status)
		@projects[:project] = status
	end
end

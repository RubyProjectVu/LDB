require 'securerandom' #random hash kuriantis metodas yra
require_relative 'projektas'

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
		@qualification_certificates = Array.new
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
		key = project.to_s.to_sym
		@projects[project] = status
	end
	
	def change_project_status(project, status)
		key = project.to_s.to_sym
		@projects[project] = status

	def create_project(project_name, project_file_name)
		object = Projektas.new(project_name: project_name, meta_filename: project_file_name)
		return object
	end

	def upload_certificate(file)
		regex = Regexp.new("([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$")

		return regex.match?(file)
	end
end

require 'securerandom' #random hash kuriantis metodas yra
require_relative 'projektas'
require 'date'

class Vartotojas
	attr_reader :name
	attr_reader :last_name
	attr_reader :email
	attr_reader	:gender
	attr_reader :user_id
	attr_reader :phone_number

	def initialize(name, last_name, email)
		@name = name
		@last_name = last_name
		@email = email
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

	def create_project(project_name, project_file_name)
		object = Projektas.new(project_name, project_file_name)
		return object
	end
end

require 'securerandom' #random hash kuriantis metodas yra

class Vartotojas
	attr_reader :name
	attr_reader :last_name
	attr_reader :email
	attr_reader	:gender
	attr_reader :user_id
	attr_reader :phone_number
	
	attr_reader :qualification_certificates
	
	def initialize(name, last_name, email)
		@name = name
		@last_name = last_name
		@email = email
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
	
	def upload_certificate(file)
		regex = Regexp.new("([a-zA-Z0-9_.\-])+(.doc|.docx|.pdf)$")
		
		return regex.match?(file)
	end
end

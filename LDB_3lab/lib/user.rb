# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'

# Documentation about class User
class User
  def initialize(name: '', last_name: '', email: '', userID: '')
    @info = { name: name, lname: last_name, email: email,
              pass: '123', userID: userID}
	if userID == ''
		@info[:userID] = SecureRandom.hex
	end
  end

  def data_getter(key)
    @info.fetch(key.to_sym)
  end
  
  def user_info
    @info
  end
  
  def password_set(new)
    # should later (5 laboras) work based on Rails gem 'EmailVeracity'
    @info[:pass] = new
  end
end

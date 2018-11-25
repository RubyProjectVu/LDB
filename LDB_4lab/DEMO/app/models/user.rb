# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class User < ApplicationRecord
  def name_set(new)
    usr = User.find_by(id: self.id)
    usr.name = new
    usr.save
  end

  def lname_set(new)
    usr = User.find_by(id: self.id)
    usr.lname = new
    usr.save
  end

  def password_set(new)
    # should later (5 laboras) work based on Rails gem 'EmailVeracity'
    return false unless pass_secure(new)
    usr = User.find_by(id: self.id)
    usr.pass = new
    usr.save
  end

  def pass_secure(pass)
    if pass.match?(/\d/)
      return true unless [nil].include?(
        pass.index(/[\+\-\!\@\#\$\%\^\&\*\(\)]/)
      )
    end
    false
  end
end

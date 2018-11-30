# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class User < ApplicationRecord
  has_many :notes_managers

  attr_reader :state

  def name_set(new)
    self.name = new
    save
  end

  def lname_set(new)
    self.lname = new
    save
  end

  def password_set(new)
    # should later (5 laboras) work based on Rails gem 'EmailVeracity'
    return false unless pass_secure(new)

    self.pass = new
    save
  end

  def pass_secure(pass)
    if pass.match?(/\d/) && state
      return true unless state && [nil].include?(
        pass.index(/[\+\-\!\@\#\$\%\^\&\*\(\)]/)
      )
    end
    false
  end
end

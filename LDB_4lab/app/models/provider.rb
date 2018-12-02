# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Provider < ApplicationRecord
  def has_offers
    return true if ProvidedMaterial.find_by(name: self.name)
    false
  end

  def materials_by_provider
    return false unless has_offers

    arr = []
    list = ProvidedMaterial.where(name: self.name)
    list.each do |mat|
      arr.push(mat.material)
    end
    arr
  end
end

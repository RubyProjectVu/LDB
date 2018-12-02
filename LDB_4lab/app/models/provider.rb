# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Provider < ApplicationRecord
  def offers?
    return true if ProvidedMaterial.find_by(name: name)

    false
  end

  def materials_by_provider
    return false unless offers?

    arr = []
    ProvidedMaterial.where(name: name).each do |mat|
      arr.push(mat.material)
    end
    arr
  end
end

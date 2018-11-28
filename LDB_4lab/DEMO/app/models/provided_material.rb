# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class ProvidedMaterial < ApplicationRecord
  def deduct_qty(provider, material, qty)
    pm = ProvidedMaterial.find_by(name: provider, material: material)
    pm.unit = pm.unit - qty
    pm.save
  end
end

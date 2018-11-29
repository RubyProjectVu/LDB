# frozen_string_literal: true

require 'securerandom' # random hash kuriantis metodas yra
require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class ProvidedMaterial < ApplicationRecord
  # On order creation
  def deduct_qty(provider, material, qty)
    self.unit -= qty
    self.save
  end

  # On order deletion
  def add_qty(provider, material, qty)
    self.unit += qty
    self.save
  end
end

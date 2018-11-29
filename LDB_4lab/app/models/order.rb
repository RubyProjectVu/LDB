# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Order < ApplicationRecord
  # after create - deduct project's budget
  def order_received(order_id)
    Order.find_by(id: order_id).destroy
  end
end

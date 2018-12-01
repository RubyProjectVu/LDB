# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Notification < ApplicationRecord
  attr_reader :state

  def state=(new)
    @state = new
  end

  def read_message(user_mail)
    notif = Notification.find_by(recvr: user_mail)
    truncate_read(user_mail)
    notif.msg
  end

  def truncate_read(user_mail)
    return false unless state
    Notification.find_by(recvr: user_mail).destroy
  end
end

# frozen_string_literal: true

require 'uri'
require './application_record'
require 'mail'

# Documentation about class User
class Notification < ApplicationRecord
  def read_message(user_mail)
    notif = Notification.find_by(recvr: user_mail)
    truncate_read(user_mail)
    notif.msg
  end

  def truncate_read(user_mail)
    Notification.find_by(recvr: user_mail).destroy
  end
end

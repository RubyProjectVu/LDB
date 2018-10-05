require 'time'

# Some docs here
class SystemProjectLogger
  # [0] - project name
  # [1] - user id
  attr_reader :latest_project_info

  def initialize(info)
    @latest_project_info = info
  end

  def log_project_creation
    File.open('syslog.txt', 'a') do |log|
      time_now = Time.now.getutc
      log.puts "Project: #{@latest_project_info[0]} " \
               "created by #{@latest_project_info[1]} at #{time_now}."
    end
  end
end

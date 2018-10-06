require 'time'

# Some docs here
class SystemProjectLogger
  attr_reader :system_file
  # [0] - project name
  # [1] - user id
  # [2] - metafile
  attr_reader :latest_project_info

  def initialize(info)
    @latest_project_info = info
    @system_file = 'syslog.txt'
  end

  def log_project_creation
    File.open(@system_file, 'a') do |log|
      time_now = Time.now.getutc
      log.puts "Project: #{@latest_project_info[0]} " \
               "created by #{@latest_project_info[1]} at #{time_now}."
    end
  end

  def latest_entry
    File.readlines(@system_file).last
  end
end

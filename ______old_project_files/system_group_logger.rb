require 'time'

# Some docs here
class SystemGroupLogger
  attr_reader :system_file
  # [0] - group name
  # [1] - user id
  attr_reader :latest_group_info

  def initialize(info)
    @latest_group_info = info
    @system_file = 'syslog.txt'
  end

  def log_work_group_creation
    File.open(@system_file, 'a') do |log|
      tn = Time.now.getutc
      log.puts "Work group: #{@latest_group_info[0]} " \
               "created by #{@latest_group_info[1]} at #{tn}."
    end
  end

  def log_work_group_deletion
    File.open(@system_file, 'a') do |log|
      tn = Time.now.getutc
      log.puts "Work group: #{@latest_group_info[0]} " \
               "deleted by #{@latest_group_info[1]} at #{tn}."
    end
  end
end

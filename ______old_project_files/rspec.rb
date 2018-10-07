require 'simplecov'
SimpleCov.start

require_relative 'projektas'
require_relative 'project_merger'
require_relative 'sistema'
require_relative 'vartotojas'
require_relative 'darbo_grupe'
require_relative 'system_project_logger'
require_relative 'system_user_logger'
require_relative 'system_group_logger'
require 'rspec'
require 'securerandom' # random hash kuriantis metodas yra
require 'etc'

require_relative 'vartotojas_spec'
require_relative 'sistema_spec'
require_relative 'projektas_spec'
require_relative 'project_merger_spec'
require_relative 'darbo_grupe_spec'

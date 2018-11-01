# frozen_string_literal: true

require 'simplecov'
require_relative '../lib/project'
SimpleCov.start

require 'yaml'

RSpec::Matchers.define :no_yml_nils do ||
  match do |actual|
    File.open actual do |file|
      file.find { |line| return false if line =~ /\{\}/ }
    end
    return true
  end
end

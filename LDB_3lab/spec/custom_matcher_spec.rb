# frozen_string_literal: true

require 'simplecov'
require_relative '../lib/project'
SimpleCov.start

require 'yaml'

describe Project do
  RSpec::Matchers.define :no_yml_nils do ||
    match do |actual|
      File.open actual do |file|
        file.find { |line| return false if line =~ /\{\}/ }
      end
      return true
    end
  end

  # Should pass the following conditions all the time
  it do
    expect('projects.yml').to no_yml_nils('projects.yml')
  end

  it do
    expect('users.yml').to no_yml_nils('users.yml')
  end

  it do
    expect('hashnil.yml').not_to no_yml_nils('hashnil.yml')
  end
end

# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

describe do
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

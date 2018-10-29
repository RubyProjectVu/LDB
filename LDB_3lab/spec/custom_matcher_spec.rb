# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

describe do

  RSpec::Matchers.define :no_yml_nils do |expected|
    match do |actual|
      File.open actual do |file|
        file.find { |line| return false if line =~ /\{\}/ }
      end
      return true
    end
  end

  # Should pass the following conditions all the time
  it do
    expect('projects.yml').to no_yml_nils
  end

  it do
    expect('users.yml').to no_yml_nils
  end

  it do
    expect('hashnil.yml').not_to no_yml_nils
  end
end

# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/budget_manager'
require_relative '../lib/project'

describe BudgetManager do
  let (:bm) { described_class.new }

  after do
    # Butina - kitaip mutant sumauna budgets.yml faila ir klasiu kintamuosius.
    hash = { 'someid' => { 'budget' => 35000 } }
    File.open('budgets.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  it do
    expect(bm.check_negative).to eq []
  end

  it do
    expect(bm.budgets_getter('someid')).to be <= 35000
  end

  it do
    expect(bm.budgets_getter('someid')).to be >= 35000
  end
end

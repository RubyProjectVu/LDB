# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/budget_manager'
require_relative '../lib/project'
require_relative 'custom_matcher'

describe BudgetManager do
  let :bm do
    described_class.new
  end

  after do
    # Butina - kitaip mutant sumauna budgets.yml faila ir klasiu kintamuosius.
    hash = { 'someid' => { 'budget' => 35_000 } }
    File.open('budgets.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
  end

  it 'no negative budgets when there aren\'t any' do
    expect(bm.check_negative).to eq []
  end

  it 'negative budgets when there are some' do
    bm.budgets_setter('newproj', -500)
    expect(described_class.new.check_negative).to match_array ['newproj']
  end

  it do
    expect(bm.budgets_getter('someid')).to be <= 35_000
  end

  it do
    expect(bm.budgets_getter('someid')).to be >= 35_000
  end

  it do
    expect { bm.budgets_getter('noid') }.to raise_error(NoMethodError)
  end

  it 'empty array when no budgets present' do
    hash = {}
    File.open('budgets.yml', 'w') do |fl|
      fl.write hash.to_yaml.gsub('---', '')
    end
    expect(described_class.new.check_negative).to be_empty
  end

  it '' do
    bm.budgets_setter('someid', 200)
    expect(described_class.new.budgets_getter('someid')).to eq 200
  end

  it 'nil on nonexisting projects' do
    expect(bm.budgets_setter('noid', 50)).to be_nil
  end

  it 'setting new budgets does not duplicate ids' do
    bm.budgets_setter('someid', 200)
    expect('someid'.to_s).to no_duplicate_budgets('budgets.yml')
  end

  it 'custom matcher works here' do
    bm.budgets_setter('newproj', -500)
    key = 'newproj'
    expect(key).not_to project_budget_positive
  end
end

# frozen_string_literal: true

#require 'simplecov'
#SimpleCov.start

#require_relative '../lib/budget_manager'
#require_relative '../lib/project'
require_relative 'custom_matcher'
require_relative '../rails_helper'

describe BudgetManager do
  let :bm do
    described_class.new
  end

  it 'no negative budgets when there aren\'t any' do
    expect(bm.check_negative).to eq []
  end

  it 'negative budgets when there are some' do
    Project.create(name: 'test', manager: 'guy', status: 'Proposed', budget: 3.5)
    id = (Project.find_by name: 'test')
    bm.budgets_setter(id, -500)
    expect(bm.check_negative).to match_array ['test']
  end

  it do
    Project.create(name: 'test', manager: 'guy', status: 'Proposed', budget: 3.5)
    id = (Project.find_by name: 'test').id
    expect(bm.budgets_getter(id)).to eq 3.5
  end

  it do
    expect { bm.budgets_getter('noid') }.to raise_error(NoMethodError)
  end
end

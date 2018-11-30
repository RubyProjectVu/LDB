# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe BudgetManager do
  let :bm do
    described_class.new
  end

  it do
    Project.create(name: 'test', manager: 'guy', status: 'Proposed',
                   budget: 3.5)
    id = (Project.find_by name: 'test').id
    expect(bm.budgets_getter(id)).to eq 3.5
  end

  it do
    expect { bm.budgets_getter('noid') }.to raise_error(NoMethodError)
  end
end

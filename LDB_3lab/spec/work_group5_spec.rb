# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative '../lib/work_group'
require_relative '../lib/user'

describe WorkGroup do
  let :wg do
    described_class.new('453', '3324', 'Test', ['tst'])
  end

  it do
    expect(wg.add_group_task('mytask')).to be true
  end

  it do
    wg.add_group_task('mytask')
    expect(wg.data_getter('tasks')).to eq %w[tst mytask]
  end

  it do
    expect(wg.delete_group_task(0)).to be true
  end

  it do
    wg.delete_group_task(0)
    expect(wg.data_getter('tasks')).to eq []
  end

  it do
    expect(wg.delete_group_task(-1)).to be false
  end

  it do
    expect(wg.delete_group_task(999)).to be false
  end
end

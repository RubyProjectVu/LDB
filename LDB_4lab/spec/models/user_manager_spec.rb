# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe UserManager do
  fixtures :all

  let(:umstb) do
    umstb = described_class.new
    # Assume no projects are managed
    allow(umstb).to receive(:manages_project?).and_return(false)
    umstb
  end

  it 'always checks for projects this user manages' do
    umstb.delete_user('tg@gmail.com')
    expect(umstb).to have_received(:manages_project?)
  end

  it 'unregistered user should not be able to login' do
    e = 't@t.com'
    expect(described_class.new.login(e, 'pass')).to be false
  end

  it 'registered user should be able to login' do
    e = 'tg@gmail.com'
    expect(described_class.new.login(e, 'p4ssw0rd')).to be true
  end

  it 'existing user cannot register again' do
    e = 'tg@gmail.com'
    v1 = described_class.new
    expect(v1.register('', '', e, 'p4ss-r')).to be false
  end

  it 'deleting existing user' do
    e = 'tg@gmail.com'
    v1 = described_class.new
    expect(v1.delete_user(e)).to be true
  end

  it 'deleting non-existing user' do
    e = 'no@no.com'
    v1 = described_class.new
    expect(v1.delete_user(e)).to be false
  end

  # TODO: active project checking will be implemented later
end

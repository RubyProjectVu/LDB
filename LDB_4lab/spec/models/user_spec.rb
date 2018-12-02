# frozen_string_literal: true

require_relative 'custom_matcher'
require_relative '../rails_helper'

describe User do
  fixtures :all

  let(:usr) do
    usr = described_class
    # No time to think of a secure pass during testing
    allow(usr).to receive(:pass_secure).and_return(true)
    usr
  end

  it 'creating a new user also checks whether password is secure' do
    usr.create(email: 'newone', pass: '123')
    expect(usr).to have_received(:pass_secure)
  end

  it 'password is set correctly' do
    described_class.create(name: 'name', lname: 'lname', email: 'email',
                           pass: 'p@ssw0rd')
    usr = described_class.find_by(name: 'name')
    usr.password_set('@1')
    expect(described_class.find_by(name: 'name').pass).to eq '@1'
  end

  it 'password is indeed advanced' do
    pass = '*as-w0rd'
    expect(pass).to has_advanced_password
  end

  it 'fails because no special characters included' do
    pass = '1simple'
    expect(pass).not_to has_advanced_password
  end
end

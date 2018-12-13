# frozen_string_literal: true

require_relative '../rails_helper'

describe UsersController do
  include Devise::Test::ControllerHelpers

  before do
    # allow(Devise).to receive(:user_signed_in?).and_return(true)
  end

  let(:uc) do
    uc = described_class
    allow_any_instance_of(uc).to receive(:find_and_login).and_return(true)
    # raises 'ActionController::UnknownFormat' otherwise
    uc
  end

  it 'present user params enable registering check' do
    hash = { 'user' => { 'email' => 'some' } }
    expect_any_instance_of(UserManager).to receive(:register)
    get :create, params: hash
  end

  it 'empty user params do not' do
    expect_any_instance_of(UserManager).not_to receive(:register)
    get :create
  end

  it 'response redirects to homepage' do
    get :index
    expect(response).to redirect_to('/welcome/index')
  end

  it 'signs user in if credentials are valid' do
    hash = { 'user' => { 'email' => 'tg@gmail.com', 'pass' => 'p4ssw0rd' } }
    expect_any_instance_of(uc).to receive(:find_and_login)
    get :parse_login, params: hash
  end

  it 'signing in is skipped otherwise' do
    hash = { 'user' => { 'email' => 'doesnot', 'pass' => 'exist' } }
    expect_any_instance_of(uc).not_to receive(:find_and_login)
    get :parse_login, params: hash
  end
end

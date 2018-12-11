# frozen_string_literal: true

require_relative '../rails_helper'

describe UsersController do
  include Devise::Test::ControllerHelpers

  before do
    #allow(Devise).to receive(user_signed_in?).and_return(true)
  end

  let(:uc) do
    uc = described_class.new
    allow(uc).to receive(:edit)
    # expected to have received <> but that <> method has not been stubbed
    uc
  end

  it do
    hash = { 'user' => { 'email' => 'some' } }
    expect_any_instance_of(UserManager).to receive(:register)
    get :create, params: hash
  end

  it do
    expect_any_instance_of(UserManager).not_to receive(:register)
    get :create
  end

  it do
    get :index
    expect(response).to redirect_to('/welcome/index')
  end
end

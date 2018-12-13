# frozen_string_literal: true

require_relative '../rails_helper'

describe WelcomeController do
  include Devise::Test::ControllerHelpers
  render_views
end

describe UsersController do
  include Devise::Test::ControllerHelpers
  render_views

  let(:upd_hash) do
    { :user => { :email => 'tg@gmail.com', :pass => '-4',
                 :name => 'nn', :lname => 'nl' } }
  end

  before do
    allow_any_instance_of(described_class).to receive(:params).and_return(upd_hash)
    # has a hash to render values from
  end

  it 'renders correct default value fill-ins' do
    sign_in(User.find_by(email: 'tg@gmail.com'))
    get :index, params: { :method => 'edit' }
    expect(response.body).to match("Email: tg@gmail.com")
  end
end

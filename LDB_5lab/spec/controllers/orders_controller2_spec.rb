# frozen_string_literal: true

require_relative '../rails_helper'

describe OrdersController do
  include Devise::Test::ControllerHelpers
  render_views

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return({'email'=>'Tomas'})
    # Cannot use sign_in since Tomas does not actually exist
  end

  it 'renders orders in page' do
    get :index
    out = response.body
                  .match?('|Order id: 15| 2018-08-05 00:00:00 UTC 100.0 WoodWorks 0.0 U8856SPPA131310') &&
          response.body.match?('|Order id: 16| 2018-08-01 00:00:00 UTC 200.0 Choppers 0.0 U8856SPPA131310') &&
          response.body.match?('|Order id: 17| 2018-11-16 00:00:00 UTC 1500.0 SteelPool 9.0 U7856Y11A13HH1L') &&
          response.body.match?('Steve 50.0 pcs Supports |Project id: 102050|')
    expect(out).to be true
  end

  it do
    get :index
    arr = []
    assigns(:my_orders).each do |o|
      o.each do |ord|
        arr.push(ord.material)
      end
    end
    expect(arr).to eq %w[Planks Planks Supports]
  end
end

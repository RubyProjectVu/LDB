# frozen_string_literal: true

require_relative '../rails_helper'

describe ProjectsController do
  include Devise::Test::ControllerHelpers
  render_views

  it 'renders form only' do
    get :create
    expect(response.body).to match('"submit" name="commit" value="Create"')
  end

  it 'sets the variable on page loading' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(assigns(:projects)).not_to be nil
  end

  it 'actually loads projects' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(response.body).to match('|201050| act8 In progress 200.0')
  end

  it 'covers mutation manager: nil/"" ' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(assigns(:projects).first.name).to eq 'act8'
  end
end

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

  it 'renders correct default value fill-ins' do
    sign_in(User.find_by(email: 'tg@gmail.com'))
    get :index, params: { :method => 'edit' }
    expect(response.body).to match("Email: tg@gmail.com")
  end
end

describe WgsController do
  include Devise::Test::ControllerHelpers
  render_views
  fixtures :all

  let(:upd_hash) do
    { :user => { :email => 'tg@gmail.com', :pass => '-4',
                 :name => 'nn', :lname => 'nl' } }
  end

  it 'renders hidden id to pass later' do
    get :addmem
    expect(response.body).to match("input type=\"hidden\" name=\"id\" id=\"id\"")
  end

  it 'actually loads managed workgroups' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(response.body).to match("|Project id: 201050| Trecia grupe 10.0")
  end

  it 'covers mutation current_user[nil/self]' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(response.body).not_to match("nilly 10.0")
  end

  it 'project is not set to nil when it is not supposed to' do
    sign_in(User.find_by(email: 'ar@gmail.com'))
    get :index
    expect(assigns(:projects)).not_to be nil
  end

  it 'no user raises error' do
    expect {get :index}.to raise_error(NoMethodError)
  end

  it 'different user renders different workgroups' do
    allow_any_instance_of(described_class).to receive(:current_user).and_return({'email'=>'Tomas'})
    get :index
    expect(response.body).to match("|Project id: 101050| Trecia grupe 10.0")
  end
end

describe TasksController do
  include Devise::Test::ControllerHelpers
  render_views

  it 'renders correct tasks' do
    get :index
    out = response.body.match?('finish something') &&
          response.body.match?('do not read this')
    expect(out).to be true
  end
end

describe SearchController do
  include Devise::Test::ControllerHelpers
  render_views

  let(:all_params) do
    { :proj => 'Project', :wgs => 'WorkGroup', :usr => 'User', 'tsk' => 'Task',
      :note => 'NotesManager', :ordr => 'Order',
      :search => { :value => 'Tomas' } }
  end

  it do
    get :show, params: all_params
    out = response.body.match?('User has:  Tomas') &&
          response.body.match?('Project has:  Tomas')
    expect(out).to be true
  end

  it do
    get :show, params: { :tsk => 'Task', :search => { :value => 'finish something' } }
    out = response.body.match?('Task has:  finish something')
    expect(out).to be true
  end

  it do
    get :show, params: { :note => 'NotesManager', :search => { :value => 'Uzrasas3' } }
    out = response.body.match?('NotesManager has:  Uzrasas3')
    expect(out).to be true
  end

  it do
    get :show, params: { :ordr => 'Order', :search => { :value => 'U7856Y11A13HH1L' } }
    out = response.body.match?('Order has:  U7856Y11A13HH1L')
    expect(out).to be true
  end

  it do
    get :show, params: { :wgs => 'WorkGroup', :search => { :value => 'Antra grupe' } }
    out = response.body.match?('WorkGroup has:  Antra grupe')
    expect(out).to be true
  end

  it 'covers -unless mutation in gathering' do
    expect {get :show}.not_to raise_error(NoMethodError)
  end
end

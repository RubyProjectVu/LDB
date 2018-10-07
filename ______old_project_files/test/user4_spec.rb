require 'simplecov'
SimpleCov.start

require_relative '../User'
require_relative '../system'
require_relative '../system_user_logger'
require_relative '../system_group_logger'
require_relative '../system_project_logger'

describe User do
  context 'when User creates a new project' do
    it 'returns true when a new project is created' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.create_project('Project', 'Project.txt')).to be_truthy
    end
  end

  context 'when a user asks for a new password' do
    it 'determines whether the email is legit' do
      # sys = System.new
      usr = described_class.new(name: 'tomas', last_name: 'genut', email: 't@')
      # expect(usr.resend_password_link).to be false
      # e = 'emailname@gmail.com'
      usr2 = described_class.new(name: 'some name',
                                 last_name: 'pavard', email: 'email@mail.eu')
      expect(!usr.resend_password_link && usr2.resend_password_link).to be true
    end
  end

  it 'returns true if new work group was created' do
    e = 'jhonpeterson@mail.com'
    vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(vart.create_work_group('Marketing')).to be_truthy
  end
end

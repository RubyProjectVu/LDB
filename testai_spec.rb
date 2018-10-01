require 'simplecov'
SimpleCov.start

require_relative 'projektas'
require_relative 'sistema'
require_relative 'vartotojas'
require 'rspec'
require 'securerandom' #random hash kuriantis metodas yra
require 'etc'

describe Projektas do

  context 'A project is validating its metadata, status and owner' do
    it 'Should be able to find and open the metadata file created after initialising' do
      proj = Projektas.new
      expect(proj.check_metadata).to be true
    end

    it 'Should initially have its owner defined as the user after creation by default' do
      proj = Projektas.new
      expect(proj.parm_manager).to eq Etc.getlogin
      proj.parm_manager('some name')
      expect(proj.parm_manager).to eq 'some name'
    end

    it 'Should check what the status is, whether it is correct, and set/return it' do
      proj = Projektas.new
      expect(proj.parm_project_status).to be nil
      expect(proj.parm_project_status('ddd')).to eq 'Please set status as one of: ' + ['Proposed', 'Suspended', 'Postponed', 'Cancelled', 'In progress'].join(', ')
      proj.parm_project_status('Proposed')
      expect(proj.project_status).to eq 'Proposed'
    end
  end

  context 'A user tries to remove its account' do
    it 'Should not be able to remove itself if there are active projects' do
      proj = Projektas.new(project_name: 'Name')
      proj.parm_project_status('In progress')
      usr = Vartotojas.new
      usr.add_project(proj.parm_project_name, proj.parm_project_status)
      expect(usr.prepare_deletion).to be false
      proj.parm_project_status('Postponed')
      usr.change_project_status(proj.parm_project_name, 'Postponed')
      expect(usr.prepare_deletion).to be true
    end
  end

  context 'Performing action with project files' do
    it 'Should return false on non existant file deletion' do
      proj = Projektas.new
      expect(proj.modify_file('filename.txt', false)).to be false
    end

    it 'Should return true on existing file deletion' do
      proj = Projektas.new
      expect(proj.modify_file('file_to_delete.txt', false)).to be true
    end

    it 'Should return true on file creation' do
      proj = Projektas.new
      expect(proj.modify_file('created_file.txt', true)).to be true
    end
  end

  context 'A new member is being added to the project' do
    it 'Should return true when a new member is added to the project' do
      proj = Projektas.new
      expect(proj.add_member(Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com'))).to be true
    end

    it 'Should return false when existing member is being added to the project' do
      proj = Projektas.new
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      proj.add_member(vart)
      expect(proj.add_member(vart)).to be false
    end

    it 'Should return false when invalid Vartotojas object is passed' do
      proj = Projektas.new
      expect(proj.add_member(nil)).to be false
    end
  end

  context 'A member is being removed from the project' do
    it 'Should return true when an existing member gets removed from the project' do
      proj = Projektas.new
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      proj.add_member(vart)
      expect(proj.remove_member(vart)).to be true
    end

    it 'Should return false when non-existing member is being removed from the project' do
      proj = Projektas.new
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      expect(proj.remove_member(vart)).to be false
    end

    it 'Should return false when invalid Vartotojas object is passed' do
      proj = Projektas.new
      expect(proj.remove_member(nil)).to be false
    end
  end
end

describe Vartotojas do

  context 'User tries to login' do

    it 'user1 should be equal to user1' do
      v1 = Vartotojas.new(name: 'name', last_name: 'lastname', email: 'email@email.com')
      v1.set_unique_id('123456789')
      expect(v1.equals(v1)).to be true
    end

    it 'registered user should be able to login' do
      sys = Sistema.new
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')#existing user
      v1.set_unique_id('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
    end

    it 'unregistered user should not be able to login' do
      sys = Sistema.new
      v1 = Vartotojas.new(name: 'no', last_name: 'user', email: 't@a.com')#not existing user
      v1.set_unique_id('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be false
    end
    
    it 'A user should not be able to login if it has  already done that' do
      sys = Sistema.new
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')#existing user
      v1.set_unique_id('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
      expect(sys.login(v1)).to be false
    end
    
  end

  context 'User tries to logout' do
    it 'should logout if user exists' do
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')#existing user
      v1.set_unique_id('48c7dcc645d82e57f049bd414daa5ae2')

      sys = Sistema.new
      expect(sys.login(v1)).to be true
      expect(sys.logout(v1)).to equal v1
    end

    it 'should return nil on error' do
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')#existing user
      v1.set_unique_id('48c7dcc645d82e57f049bd414daa5ae2')
      expect(Sistema.new.logout(v1)).to be nil
    end
    
  end

  context 'User uploads qualification certificates' do
    it 'should return true if file is accepted' do

    v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    v1.set_unique_id()
    expect(v1.upload_certificate('file.docx')).to be true
    expect(v1.upload_certificate('file.doc')).to be true
    expect(v1.upload_certificate('file.pdf')).to be true

    end

    it 'should return false if file is of wrong format' do

    v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    v1.set_unique_id()
    expect(v1.upload_certificate('file.ff')).to be false
    expect(v1.upload_certificate('file.exe')).to be false
    expect(v1.upload_certificate('file.png')).to be false
    expect(v1.upload_certificate('.gimp')).to be false
    expect(v1.upload_certificate('.doc')).to be false
    expect(v1.upload_certificate('.pdf')).to be false
    expect(v1.upload_certificate('.docx')).to be false

    end
  end

  context 'Vartotojas creates a new project' do
    it 'Should return true when a new project is created' do
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      expect(vart.create_project('Project', 'Project.txt')).to be_truthy
    end
  end

  context 'Vartotojas deletes a project' do
    it 'Should return false when nil is being passed to delete_project' do
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      expect(vart.delete_project(nil)).to be false
    end

    it 'Should return true when project is deleted' do
      proj = Projektas.new
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      expect(vart.delete_project(proj)).to be true
    end

    it 'Should return false when project is already deleted' do
      proj = Projektas.new
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: 'jhonpeterson@mail.com')
      vart.delete_project(proj)
      expect(vart.delete_project(proj)).to be false
    end
  end
  
  context 'User asks for a new password' do
    it 'Should determine whether the email is legit and capable of receiving the link' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      expect(usr.resend_password_link).to be false
      usr = Vartotojas.new(name: 'some name', last_name: 'pavardenis', email: 'emailname@gmail.com')
      expect(usr.resend_password_link).to be true
    end
  end

end

describe Sistema do
  
  context 'The system should monitor user loggin in and out activity' do
    it 'The system should log a user login or logout' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      sys.login(usr)
      sys.log_user_login_logout('tomas', 'genut')
      expect(sys.get_latest_entry).to start_with 'User: tomas genut '
      expect(sys.get_latest_entry).to include('logged in at')
      sys.logout(usr)
      sys.log_user_login_logout('tomas', 'genut', false)
      expect(sys.get_latest_entry).to start_with 'User: tomas genut '
      expect(sys.get_latest_entry).to include('logged out at')
    end
    
    it 'The system should log a password reset link request and see the email and user' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'some name', last_name: 'pavardenis', email: 'emailname@gmail.com')
      usr.resend_password_link
      sys.log_password_request('some name', 'pavardenis', 'emailname@gmail.com')
      expect(sys.get_latest_entry).to start_with 'Password request for user: some name pavardenis to emailname@gmail.com'
    end
    
    it 'The system should log a project creation' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      usr.set_unique_id
      proj = usr.create_project('some name', 'some_meta.txt')
      sys.log_project_creation(proj.parm_project_name, usr)
      expect(sys.get_latest_entry).to start_with "Project: #{proj.parm_project_name} created by #{usr.get_unique_id} at"
    end
  end
end

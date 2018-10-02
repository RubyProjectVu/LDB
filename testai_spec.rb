require 'simplecov'
SimpleCov.start

require_relative 'projektas'
require_relative 'project_merger'
require_relative 'sistema'
require_relative 'vartotojas'
require 'rspec'
require 'securerandom' # random hash kuriantis metodas yra
require 'etc'

describe Projektas do
  context 'A project is validating its metadata, status and owner' do
    it 'Should be able to find and open the metadata file created after init' do
      proj = Projektas.new
      expect(proj.check_metadata).to be true
    end

    it 'Should have its owner defined as the user after creation by default' do
      proj = Projektas.new
      expect(proj.parm_manager).to eq Etc.getlogin
      # proj.parm_manager('some name')
      # expect(proj.parm_manager).to eq 'some name'
    end

    it 'Should have its owner set correctly' do
      proj = Projektas.new
      # expect(proj.parm_manager).to eq Etc.getlogin
      proj.parm_manager('some name')
      expect(proj.parm_manager).to eq 'some name'
    end

    it 'Should not set an undefined status' do
      proj = Projektas.new
      expect(proj.parm_project_status).to be nil
      str1 = 'Please set status as one of: '
      str2 = ['Proposed', 'Suspended', 'Postponed',
              'Cancelled', 'In progress'].join(', ')
      expect(proj.parm_project_status('ddd')).to eq str1 + str2
      # proj.parm_project_status('Proposed')
      # expect(proj.project_status).to eq 'Proposed'
    end

    it 'Should set/return valid status' do
      proj = Projektas.new
      expect(proj.parm_project_status).to be nil
      # str1 = 'Please set status as one of: '
      # str2 = ['Proposed', 'Suspended', 'Postponed',
      #        'Cancelled', 'In progress'].join(', ')
      # expect(proj.parm_project_status('ddd')).to eq str1 + str2
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
      # proj.parm_project_status('Postponed')
      # usr.change_project_status(proj.parm_project_name, 'Postponed')
      # expect(usr.prepare_deletion).to be true
    end

    it 'Should be able to remove itself if there are no active projects' do
      proj = Projektas.new(project_name: 'Name')
      proj.parm_project_status('Postponed')
      usr = Vartotojas.new
      usr.add_project(proj.parm_project_name, proj.parm_project_status)
      expect(usr.prepare_deletion).to be true
      # proj.parm_project_status('Postponed')
      # usr.change_project_status(proj.parm_project_name, 'Postponed')
      # expect(usr.prepare_deletion).to be true
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
      e = 'jhonpeterson@mail.com'
      usr = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.add_member(usr)).to be true
    end

    it 'Return false when existing member is being added to the project' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.add_member(vart)).to be false
    end

    it 'Should return false when invalid Vartotojas object is passed' do
      proj = Projektas.new
      expect(proj.add_member(nil)).to be false
    end
  end

  context 'A member is being removed from the project' do
    it 'True when an existing member gets removed from the project' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.remove_member(vart)).to be true
    end

    it 'Should return false when nonmember is being removed from the project' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.remove_member(vart)).to be false
    end

    it 'Should return false when invalid Vartotojas object is passed' do
      proj = Projektas.new
      expect(proj.remove_member(nil)).to be false
    end
  end

  context 'Project subscriber list manipulation' do
    it 'Should allow one member per name' do
      proj = Projektas.new
      e = 'u1email@gmail.com'
      expect(proj.add_subscriber('name lastname', e)).not_to be false
      expect(proj.add_subscriber('name lastname', e)).to be_falsey
      expect(proj.remove_subscriber('name lastname')).not_to be false
    end

    it 'Should correctly find current subscribers' do
      proj = Projektas.new
      e = 'u1email@gmail.com'
      proj.add_subscriber('name lastname', e)
      proj.add_subscriber('josh lastname', e)
      expect(proj.notify_subscribers).to eq ['name lastname', 'josh lastname']
      proj.remove_subscriber('name lastname')
      expect(proj.notify_subscribers).to eq ['josh lastname']
    end
  end
end

describe Vartotojas do
  context 'User tries to login' do
    it 'user1 should be equal to user1' do
      e = 'email@email.com'
      v1 = Vartotojas.new(name: 'name', last_name: 'lastname', email: e)
      v1.unique_id_setter('123456789')
      expect(v1.equals(v1)).to be true
    end

    it 'registered user should be able to login' do
      sys = Sistema.new
      e = 't@a.com'
      # existing user
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
    end

    it 'unregistered user should not be able to login' do
      sys = Sistema.new
      e = 't@a.com'
      # not existing user
      v1 = Vartotojas.new(name: 'no', last_name: 'user', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be false
    end

    it 'A user should not be able to login if it has already done that' do
      sys = Sistema.new
      e = 't@a.com'
      # existing user
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
      expect(sys.login(v1)).to be false
    end
  end

  context 'User tries to logout' do
    it 'should logout if user exists' do
      # existing user
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')

      sys = Sistema.new
      expect(sys.login(v1)).to be true
      expect(sys.logout(v1)).to equal v1
    end

    it 'should return nil on error' do
      # existing user
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(Sistema.new.logout(v1)).to be nil
    end
  end

  context 'User uploads qualification certificates' do
    it 'should return true if file is accepted' do
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      expect(v1.upload_certificate('file.docx')).to be true
      expect(v1.upload_certificate('file.doc')).to be true
      expect(v1.upload_certificate('file.pdf')).to be true
    end

    it 'should return false if file is of wrong format' do
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
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
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.create_project('Project', 'Project.txt')).to be_truthy
    end
  end

  context 'Vartotojas deletes a project' do
    it 'Should return false when nil is being passed to delete_project' do
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(nil)).to be false
    end

    it 'Should return true when project is deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(proj)).to be true
    end

    it 'Should return false when project is already deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      vart.delete_project(proj)
      expect(vart.delete_project(proj)).to be false
    end
  end

  context 'User asks for a new password' do
    it 'Should determine whether the email is legit' do
      # sys = Sistema.new
      e = 't@a.com'
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: e)
      expect(usr.resend_password_link).to be false
      e = 'emailname@gmail.com'
      usr = Vartotojas.new(name: 'some name', last_name: 'pavardenis', email: e)
      expect(usr.resend_password_link).to be true
    end
  end
end

describe Sistema do
  context 'User tries to register' do
    it 'Should return false if user with that email already exists' do
      sys = Sistema.new
      usr1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      usr2 = Vartotojas.new(name: 'genut', last_name: 'tomas', email: 'g@a.com')
      expect(sys.register(usr1)).to be false
      expect(sys.register(usr2)).to be false
    end

    it 'Should return false if users email wont match email template' do
      sys = Sistema.new
      usr1 = Vartotojas.new(name: 'qwert', last_name: 'setas', email: 'ga23am')
      usr2 = Vartotojas.new(name: 'genut', last_name: 'tomas', email: 'g@am')
      expect(sys.user_input_validation(usr1)).to be false
      expect(sys.user_input_validation(usr2)).to be false
    end

    it 'Should return true if all user input passes validation' do
      sys = Sistema.new
      usr1 = Vartotojas.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
      expect(sys.user_input_validation(usr1)).to be true
    end

    it 'Should return true if user successfully registered' do
      sys = Sistema.new
      usr1 = Vartotojas.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
      expect(sys.user_input_validation(usr1)).to be true
      expect(sys.register(usr1)).to be true
    end
  end

  context 'System should monitor user loggin in, out' do
    it 'The system should log a user login' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      sys.login(usr)
      sys.log_user_login_logout('tomas', 'genut')
      expect(sys.latest_entry).to start_with 'User: tomas genut '
      expect(sys.latest_entry).to include('logs in at')
      sys.logout(usr)
      sys.log_user_login_logout('tomas', 'genut', false)
      expect(sys.latest_entry).to start_with 'User: tomas genut '
      expect(sys.latest_entry).to include('logs out at')
    end

    it 'The system should log a user logout' do
      sys = Sistema.new
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      sys.login(usr)
      sys.log_user_login_logout('tomas', 'genut')
      sys.logout(usr)
      sys.log_user_login_logout('tomas', 'genut', false)
      expect(sys.latest_entry).to start_with 'User: tomas genut '
      expect(sys.latest_entry).to include('logs out at')
    end

    it 'The system should log a request and see the email and user' do
      sys = Sistema.new
      e = 'emailname@gmail.com'
      usr = Vartotojas.new(name: 'some name', last_name: 'pavardenis', email: e)
      usr.resend_password_link
      e = 'emailname@gmail.com'
      sys.log_password_request('some name', 'pavardenis', e)
      s1 = 'Pass req for user: some name '
      s2 = 'pavardenis to emailname@gmail.com'
      expect(sys.latest_entry).to start_with s1 + s2
    end

    it 'The system should log a project creation' do
      sys = Sistema.new
      e = 't@a.com'
      usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: e)
      usr.unique_id_setter
      proj = usr.create_project('some name', 'some_meta.txt')
      sys.log_project_creation(proj.parm_project_name, usr)
      s1 = "Project: #{proj.parm_project_name} created "
      s2 = "by #{usr.unique_id_getter} at"
      expect(sys.latest_entry).to start_with s1 + s2
    end

    it 'Should log a certificate upload' do
      sys = Sistema.new
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      fname = 'file.pdf'
      v1.upload_certificate(fname)
      sys.log_certificate_upload('tomas', 'genut', fname)
      str = "User: tomas genut uploaded a certification #{fname}"
      expect(sys.latest_entry).to start_with str
    end
  end
end

describe ProjectMerger do
  it 'should not continue merging when a file is missing' do
    pm = ProjectMerger.new
    expect(pm.prepare_merge('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'should not continue notifying when a file is missing' do
    pm = ProjectMerger.new
    expect(pm.notify_managers('nofile.txt', 'nofile2.txt')).to be false
  end

  it 'should not be able to merge into self' do
    pm = ProjectMerger.new
    Projektas.new
    fileone = File.open('metadata.txt', 'w')
    fileone.puts('projid: 1')
    fileone.close
    expect(pm.prepare_merge('metadata.txt', 'metadata.txt')).to be false
  end

  it 'should have no issues on different ids' do
    pm = ProjectMerger.new
    Projektas.new
    Projektas.new(meta_filename: 'metadata2.txt')
    # write ids to both
    fileone = File.open('metadata.txt', 'w')
    filetwo = File.open('metadata2.txt', 'w')
    fileone.puts('projid: 1')
    filetwo.puts('projid: 2')
    fileone.close
    filetwo.close
    expect(pm.prepare_merge('metadata.txt', 'metadata2.txt')).to be true
  end

  it 'should find the manager in metafile' do
    pm = ProjectMerger.new
    Projektas.new
    # write manager
    fileone = File.open('metadata.txt', 'w')
    fileone.puts('manager: somename')
    fileone.close
    expect(pm.get_manager_from_meta('metadata.txt')).to eq 'somename'
  end

  it 'should return empty string otherwise' do
    pm = ProjectMerger.new
    Projektas.new
    expect(pm.get_manager_from_meta('metadata.txt')).to eq ''
  end

  it 'should notify managers of both projects' do
    pm = ProjectMerger.new
    Projektas.new
    Projektas.new(meta_filename: 'metadata2.txt')
    fileone = File.open('metadata.txt', 'w')
    filetwo = File.open('metadata2.txt', 'w')
    # set managers to both
    fileone.puts('manager: somename')
    filetwo.puts('manager: othername')
    fileone.close
    filetwo.close
    words = %w[somename othername]
    expect(pm.notify_managers('metadata.txt', 'metadata2.txt')).to eql words
  end
end

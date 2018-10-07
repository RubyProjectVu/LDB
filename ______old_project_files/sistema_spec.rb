describe Sistema do
  context 'when a user tries to remove its account' do
    it 'is not able to remove itself if there are active projects' do
      proj = Projektas.new(project_name: 'Name')
      proj.parm_project_status('In progress')
      usr = Vartotojas.new
      usr.add_project(proj.parm_project_name, proj.parm_project_status)
      expect(usr.prepare_deletion).to be false
      # proj.parm_project_status('Postponed')
      # usr.change_project_status(proj.parm_project_name, 'Postponed')
      # expect(usr.prepare_deletion).to be true
    end
  end

  context 'when performing action with project files' do
    it 'returns false on non existant file deletion' do
      proj = Projektas.new
      expect(proj.modify_file('filename.txt', false)).to be false
    end

    it 'returns true on existing file deletion' do
      proj = Projektas.new
      expect(proj.modify_file('file_to_delete.txt', false)).to be true
    end

    it 'returns true on file creation' do
      proj = Projektas.new
      expect(proj.modify_file('created_file.txt', true)).to be true
    end
  end

  context 'when a user tries to register' do
    it 'returns false if user with that email already exists' do
      sys = described_class.new
      usr1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      usr2 = Vartotojas.new(name: 'genut', last_name: 'tomas', email: 'g@a.com')
      expect(sys.register(usr1)).to be false
      expect(sys.register(usr2)).to be false
    end

    it 'returns false if users email wont match email template' do
      sys = described_class.new
      usr1 = Vartotojas.new(name: 'qwert', last_name: 'setas', email: 'ga23am')
      usr2 = Vartotojas.new(name: 'genut', last_name: 'tomas', email: 'g@am')
      expect(sys.user_input_validation(usr1)).to be false
      expect(sys.user_input_validation(usr2)).to be false
    end

    it 'returns true if user successfully registered' do
      sys = described_class.new
      usr1 = Vartotojas.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
      expect(sys.user_input_validation(usr1)).to be true
      expect(sys.register(usr1)).to be true
    end
  end

  it 'returns true if all user input passes validation' do
    sys = described_class.new
    usr1 = Vartotojas.new(name: 'jonas', last_name: 'jon', email: 'j@j.com')
    expect(sys.user_input_validation(usr1)).to be true
  end

  it 'The system should log a work group deletion' do
    sys = described_class.new
    group = DarboGrupe.new
    v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    v1.unique_id_setter
    # sys.log_work_group_deletion(group.parm_work_group_name, v1)
    s1 = "Work group: #{group.parm_work_group_name} deleted "
    s2 = "by #{v1.unique_id_getter} at"
    v1.delete_work_group(group)
    expect(sys.latest_entry).to start_with s1 + s2
  end

  it 'The system should log a user login' do
    sys = described_class.new
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

  it 'The system should log a project creation' do
    sys = described_class.new
    e = 't@a.com'
    usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: e)
    usr.unique_id_setter
    proj = usr.create_project('some name', 'some_meta.txt')
    # sys.log_project_creation(proj.parm_project_name, usr)
    s1 = "Project: #{proj.parm_project_name} created "
    s2 = "by #{usr.unique_id_getter} at"
    expect(sys.latest_entry).to start_with s1 + s2
  end

  context 'when system should monitor user loggin in, out' do
    it 'logs a certificate upload' do
      sys = described_class.new
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      fname = 'file.pdf'
      v1.upload_certificate(fname)
      # sys.log_certificate_upload('tomas', 'genut', fname)
      str = "User: tomas genut uploaded a certification #{fname}"
      expect(sys.latest_entry).to start_with str
    end

    it 'The system should log a work group creation' do
      sys = described_class.new
      v1 = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
      v1.unique_id_setter
      group = v1.create_work_group('some name')
      sys.log_work_group_creation(group.parm_work_group_name, v1)
      s1 = "Work group: #{group.parm_work_group_name} created "
      s2 = "by #{v1.unique_id_getter} at"
      expect(sys.latest_entry).to start_with s1 + s2
    end
  end

  it 'The system should log a user logout' do
    sys = described_class.new
    usr = Vartotojas.new(name: 'tomas', last_name: 'genut', email: 't@a.com')
    sys.login(usr)
    # sys.log_user_login_logout('tomas', 'genut')
    sys.logout(usr)
    # sys.log_user_login_logout('tomas', 'genut', false)
    expect(sys.latest_entry).to start_with 'User: ["tomas", "genut"] '
    # expect(sys.latest_entry).to include('logs out at')
  end

  it 'The system should log a request and see the email and user' do
    sys = described_class.new
    e = 'emailname@gmail.com'
    usr = Vartotojas.new(name: 'some name', last_name: 'pavardenis', email: e)
    usr.resend_password_link
    e = 'emailname@gmail.com'
    # sys.log_password_request('some name', 'pavardenis', e)
    s1 = 'Password request for user:'
    expect(sys.latest_entry).to start_with s1
  end
end

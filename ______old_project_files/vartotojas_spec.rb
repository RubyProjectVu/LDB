describe Vartotojas do
  it 'returns true if new work group was created' do
    e = 'jhonpeterson@mail.com'
    vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
    expect(vart.create_work_group('Marketing')).to be_truthy
  end

  context 'when a user deletes a work group' do
    it 'returns false when nil is being passed to delete_work_group' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_work_group(nil)).to be false
    end

    it 'returns true when work group is deleted' do
      group = DarboGrupe.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_work_group(group)).to be true
    end

    it 'returns false when work group is already deleted' do
      group = DarboGrupe.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      vart.delete_work_group(group)
      expect(vart.delete_work_group(group)).to be false
    end
  end

  context 'when vartotojas creates a new project' do
    it 'returns true when a new project is created' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.create_project('Project', 'Project.txt')).to be_truthy
    end
  end

  context 'when a user asks for a new password' do
    it 'determines whether the email is legit' do
      # sys = Sistema.new
      e = 't@a.com'
      usr = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      expect(usr.resend_password_link).to be false
      e = 'emailname@gmail.com'
      usr = described_class.new(name: 'some name', last_name: 'pavardenis',
                                email: e)
      expect(usr.resend_password_link).to be true
    end
  end

  context 'when vartotojas deletes a project' do
    it 'returns false when nil is being passed to delete_project' do
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(nil)).to be false
    end

    it 'returns true when project is deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(vart.delete_project(proj)).to be true
    end

    it 'returns false when project is already deleted' do
      proj = Projektas.new
      e = 'jhonpeterson@mail.com'
      vart = described_class.new(name: 'Jhon', last_name: 'Peterson', email: e)
      vart.delete_project(proj)
      expect(vart.delete_project(proj)).to be false
    end
  end

  context 'when a user uploads qualification certificates' do
    it 'returns true if file is accepted' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
      v1.unique_id_setter
      expect(v1.upload_certificate('file.docx')).to be true
      expect(v1.upload_certificate('file.doc')).to be true
      expect(v1.upload_certificate('file.pdf')).to be true
    end

    it 'returns false if file is of wrong format' do
      v1 = described_class.new(name: 'tomas', last_name: 'genut',
                               email: 't@a.com')
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

  it 'when a user should not be able to login if it has already done that' do
    sys = Sistema.new
    # existing user
    v1 = described_class.new(name: 'tomas', last_name: 'genut',
                             email: 't@a.com')
    v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
    # expect(sys.login(v1)).to be true
    sys.login(v1)
    expect(sys.login(v1)).to be false
  end

  context 'when a user tries to logout' do
    it 'logs out if user exists' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')

      sys = Sistema.new
      expect(sys.login(v1)).to be true
      # expect(sys.logout(v1)).to equal v1
    end

    it 'returns nil on error' do
      # existing user
      e = 't@a.com'
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(Sistema.new.logout(v1)).to be nil
    end
  end

  context 'when a user tries to login' do
    it 'user1 should be equal to user1' do
      e = 'email@email.com'
      v1 = described_class.new(name: 'name', last_name: 'lastname', email: e)
      v1.unique_id_setter('123456789')
      expect(v1.equals(v1)).to be true
    end

    it 'registered user should be able to login' do
      sys = Sistema.new
      e = 't@a.com'
      # existing user
      v1 = described_class.new(name: 'tomas', last_name: 'genut', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be true
    end

    it 'unregistered user should not be able to login' do
      sys = Sistema.new
      e = 't@a.com'
      # not existing user
      v1 = described_class.new(name: 'no', last_name: 'user', email: e)
      v1.unique_id_setter('48c7dcc645d82e57f049bd414daa5ae2')
      expect(sys.login(v1)).to be false
    end
  end
end

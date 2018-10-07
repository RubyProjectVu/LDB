

describe Projektas do
  it 'do not set an undefined status' do
    proj = described_class.new
    str1 = 'Please set status as one of: '
    str2 = ['Proposed', 'Suspended', 'Postponed',
            'Cancelled', 'In progress'].join(', ')
    expect(proj.parm_project_status('ddd')).to eq str1 + str2
  end

  it 'is be able to remove itself if there are no active projects' do
    proj = described_class.new(project_name: 'Name')
    proj.parm_project_status('Postponed')
    usr = Vartotojas.new
    usr.add_project(proj.parm_project_name, proj.parm_project_status)
    expect(usr.prepare_deletion).to be true
  end

  context 'when project is validating its metadata, status, owner' do
    it 'is able to find/open the metadata file created after init' do
      proj = described_class.new
      expect(proj.check_metadata).to be true
    end

    it 'has its owner set correctly' do
      proj = described_class.new
      proj.parm_manager('some name')
      expect(proj.parm_manager).to eq 'some name'
    end

    it 'sets/returns valid status' do
      proj = described_class.new
      proj.parm_project_status('Proposed')
      expect(proj.project_status).to eq 'Proposed'
    end
  end

  it 'has its owner defined as the user after creation by default' do
    proj = described_class.new
    expect(proj.parm_manager).to eq Etc.getlogin
  end

  context 'when a new member is being added to the project' do
    it 'returns true when a new member is added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      usr = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.add_member(usr)).to be true
    end

    it 'Return false when existing member is being added to the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.add_member(vart)).to be false
    end
  end

  context 'when a member is being removed from the project' do
    it 'True when an existing member gets removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      proj.add_member(vart)
      expect(proj.remove_member(vart)).to be true
    end

    it 'returns false when nonmember is being removed from the project' do
      proj = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(proj.remove_member(vart)).to be false
    end
  end

  context 'when project subscriber list manipulation' do
    it 'allows one member per name' do
      proj = described_class.new
      e = 'u1email@gmail.com'
      # expect(proj.add_subscriber('name lastname', e)).not_to be false
      proj.add_subscriber('name lastname', e)
      expect(proj.add_subscriber('name lastname', e)).to be_falsey
      # expect(proj.remove_subscriber('name lastname')).not_to be false
    end

  it 'correctly finds current subscribers' do
      proj = described_class.new
      e = 'u1email@gmail.com'
      proj.add_subscriber('name lastname', e)
      proj.add_subscriber('josh lastname', e)
      expect(proj.notify_subscribers).to eq ['name lastname', 'josh lastname']
      # proj.remove_subscriber('name lastname')
      # expect(proj.notify_subscribers).to eq ['josh lastname']
    end
  end
end

describe DarboGrupe do
  context 'when a member is being removed from the work_group' do
    it 'true when an existing member gets removed from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_member(vart)
      expect(group.remove_member(vart)).to be true
    end

    it 'false if trying to remove non-existing member from the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.remove_member(vart)).to be false
    end
  end

  context 'when work group is validating its name, and owner' do
    it 'initially defines creator as am owner' do
      group = described_class.new
      expect(group.parm_manager).to eq Etc.getlogin
    end
  end

  context 'when a new member is being added to the work_group' do
    it 'Returns true when a new member is added to the work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      expect(group.add_member(vart)).to be true
    end

    it 'false if work group member is added again to the same work_group' do
      group = described_class.new
      e = 'jhonpeterson@mail.com'
      vart = Vartotojas.new(name: 'Jhon', last_name: 'Peterson', email: e)
      group.add_member(vart)
      expect(group.add_member(vart)).to be false
    end

    it '' do
      item = SystemProjectLogger.new(["projname", "1410154"])
      item.log_project_creation
    end
  end
end

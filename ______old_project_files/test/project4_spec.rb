require 'simplecov'
SimpleCov.start

require_relative '../project'
require_relative '../User'

describe Project do
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

  it 'has its owner defined as the user after creation by default' do
    proj = described_class.new
    expect(proj.parm_manager).to eq Etc.getlogin
    # proj.parm_manager('some name')
    # expect(proj.parm_manager).to eq 'some name'
  end
end

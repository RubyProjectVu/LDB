require 'simplecov'
SimpleCov.start

require_relative 'projektas'
require_relative 'vartotojas'
require 'rspec'
require 'securerandom' #random hash kuriantis metodas yra
require 'etc'



describe Projektas do

	context "The project is validating its metadata, status and owner" do
		it "Should be able to find and open the metadata file created after initialising" do
			proj = Projektas.new
			expect(proj.check_metadata).to be true
		end

		it "Should initially have its owner defined as the user after creation by default" do
			proj = Projektas.new
			expect(proj.parm_manager).to eq Etc.getlogin
			proj.parm_manager("some name")
			expect(proj.parm_manager).to eq "some name"
		end

		it "Should check what the status is, whether it's correct, and set/return it" do
			proj = Projektas.new
			expect(proj.parm_project_status).to be nil
			expect(proj.parm_project_status("ddd")).to eq "Please set status as one of: " + ['Proposed', 'Suspended', 'Postponed', 'Cancelled'].join(", ")
			proj.parm_project_status("Proposed")
			expect(proj.project_status).to eq "Proposed"
		end
	end

	context "Performing action with project files" do
		it "Should return false on non existant file deletion" do
			proj = Projektas.new
			expect(proj.modify_file("filename.txt", false)).to be false
		end

		#it "Should return true on existing file deletion" do
		#	proj = Projektas.new
		#	expect(proj.modify_file("file_to_delete.txt", false)).to be true
		#end

		it "Should return true on file creation" do
			proj = Projektas.new
			expect(proj.modify_file("created_file.txt", true)).to be true
		end
	end

	context "Vartotojas creates a new project" do
		it "Shoud not return nil on project creation" do
			vart = Vartotojas.new("Jhon", "Peterson", "jhonpeterson@mail.com")
			expect(vart.create_project("Project", "Project.txt")).to be_truthy
		end
	end

end

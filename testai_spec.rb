require_relative 'projektas'
require_relative 'sistema'
require 'rspec'

describe Projektas do
	
	context "The project is validating its metadata, status and owner" do
		it "Should be able to find and open the metadata file created after initialising" do
			proj = Projektas.new
			expect(proj.check_metadata).to be true
		end
		
		it "Should initially have its owner undefined after creation by default" do
			proj = Projektas.new
			expect(proj.project_manager).to eq "undefined"
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
	
end

describe Vartotojas do

	context "User tries to login" do
		
		it "user1 should be equal to user1" do
			v1 = Vartotojas.new("name", "lastname", "email@email.com")
			v1.set_unique_id("123456789")
			expect(v1.equals(v1)).to be true
		end
		
		it "registered user should be able to login" do
			sys = Sistema.new
			v1 = Vartotojas.new("tomas", "genut", "t@a.com")#existing user
			v1.set_unique_id("48c7dcc645d82e57f049bd414daa5ae2")
			expect(sys.login(v1)).to be true
		end
		
		it "unregistered user should not be able to login" do
			sys = Sistema.new
			v1 = Vartotojas.new("no", "user", "t@a.com")#not existing user
			v1.set_unique_id("48c7dcc645d82e57f049bd414daa5ae2")
			expect(sys.login(v1)).to be false
		end
	end
	
	context "User tries to logout" do
		it "should logout if user exists" do
			v1 = Vartotojas.new("tomas", "genut", "t@a.com")#existing user
			v1.set_unique_id("48c7dcc645d82e57f049bd414daa5ae2")
			
			sys = Sistema.new
			expect(sys.login(v1)).to be true
			expect(sys.logout(v1)).to equal v1
		end
		
		it "should return nil on error" do
			v1 = Vartotojas.new("tomas", "genut", "t@a.com")#existing user
			v1.set_unique_id("48c7dcc645d82e57f049bd414daa5ae2")
			expect(Sistema.new.logout(v1)).to be nil
		end
	end
	
	context "User uploads qualification certificates" do
		it "should return true if file is accepted" do
		
		v1 = Vartotojas.new("tomas", "genut", "t@a.com")
		v1.set_unique_id()
		expect(v1.upload_certificate("file.docx")).to be true
		expect(v1.upload_certificate("file.doc")).to be true
		expect(v1.upload_certificate("file.pdf")).to be true
		
		end
		
		it "should return false if file is of wrong format" do
		
		v1 = Vartotojas.new("tomas", "genut", "t@a.com")
		v1.set_unique_id()
		expect(v1.upload_certificate("file.ff")).to be false
		expect(v1.upload_certificate("file.exe")).to be false
		expect(v1.upload_certificate("file.png")).to be false
		expect(v1.upload_certificate(".gimp")).to be false
		expect(v1.upload_certificate(".doc")).to be false
		expect(v1.upload_certificate(".pdf")).to be false
		expect(v1.upload_certificate(".docx")).to be false
		
		end
	end
	
end

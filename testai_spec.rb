require_relative 'projektas'
require 'rspec'
require 'securerandom' #random hash kuriantis metodas yra

describe Projektas do
	
	context "Add stuff to Projektas as needed" do
		it "Should emit something here" do
			#proj = Projektas.new
			#proj.set_value(3)
			#expect(proj.return_value).to eq 3
		end
	end
	
	context "The project opens its metadata file after being created" do
		it "Should be able to find and open the file" do
			proj = Projektas.new
			expect(proj.check_metadata).to be true
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
			expect(proj.modify_file("created_file.txt", true)).to be false
		end
	end
	
	
end

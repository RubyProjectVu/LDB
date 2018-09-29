require_relative 'projektas'
require 'rspec'

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
end

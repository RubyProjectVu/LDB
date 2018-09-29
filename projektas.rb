require 'date'

class Projektas
<<<<<<< HEAD
	attr_accessor value
	def return_value
		return @value
=======
	attr_accessor :meta_filename
	attr_accessor :project_name
	
	def initialize(project_name = "Default_project_" + Date.today.to_s, meta_filename = "metadata.txt")
		@project_name = project_name
		@meta_filename = meta_filename
		metafile = File.new(meta_filename, "w")
		metafile.close
>>>>>>> paulius
	end
	
	def check_metadata
		outcome = File.file?(@meta_filename)
		if outcome
			File.foreach(@meta_filename, "r") {|line| print "Check if #{line} exists"}
			return true
		else 
			return false
		end
	end
	
	#def save_metadata
		
	#end
	
	#def tear_down_project
		
	#end
end
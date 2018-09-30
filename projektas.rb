require 'date'
require 'etc'

class Projektas
	attr_reader :meta_filename
	attr_reader :project_name
	attr_reader :project_manager
	attr_reader :project_status
	attr_reader :members

	def initialize(project_name = "Default_project_" + Date.today.to_s, meta_filename = "metadata.txt")
		@project_name = project_name
		@meta_filename = meta_filename
		@project_manager = Etc.getlogin
		metafile = File.new(meta_filename, "w")
		metafile.close
		@members = Array.new
	end

	def check_metadata
		outcome = File.file?(@meta_filename)
		if outcome
			File.foreach(@meta_filename, "r") {|line| print "Check if #{line} exists"}
			return true
		end
	end

	def modify_file(file_name, create_file)
		if(create_file)
			File.new(file_name, "w")
			return true;
		else
			begin
				return File.delete(file_name) == 1
			rescue
				return false
			end
		end
	end

	def parm_manager(name = "")
		#should ideally receive input from user
		if !name.to_s.empty?
			@project_manager = name
		else
			return @project_manager
		end
	end

	def parm_project_status(status = "")
		if !status.to_s.empty?
			if ['Proposed', 'Suspended', 'Postponed', 'Cancelled'].include? status
				#should ideally notify participants if status changes to 'suspended' or so
				@project_status = status
			else
				return "Please set status as one of: " + ['Proposed', 'Suspended', 'Postponed', 'Cancelled'].join(", ")
			end
		else
			return @project_status
		end
	end

	def add_member(Vartotojas vart)
		if vart == nil
			puts "Invalid Vartotojas"
			return false
		end

		if @members.include?(vart.user_id)
			puts "This member is already assigned to this project"
			return false
		end

		@members.push(vart.user_id)
		return true
	end

	def remove_member(Vartotojas vart)
		if vart == nil
			puts "Invalid Vartotojas"
			return false
		end

		if !@members.include?(vart.user_id)
			puts "This member is not assigned to this project"
			return false
		end

		@members.delete(vart.user_id)
		return true
	end

end

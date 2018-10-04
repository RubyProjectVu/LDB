require_relative 'file_manager/FileManager'

class System
   attr_reader :test

   def initialize
      @FileManager = FileManager.new
      @test = false
   end

end

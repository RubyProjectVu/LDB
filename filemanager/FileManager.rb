

class FileManager

   def initialize

   end

   # Reads meta data from a file
   # Line Format: XXXX, XXXX, XXXX...
   def read_metadata(filename, line_id, index)

      lines = File.readlines(filename)
      line = lines[line_id]
      res = line.split(',')
      return res[index]

   end

   # Writes meta data to a file
   # Line Format: XXXX, XXXX, XXXX...
   def write_metadata(filename, line_id, index, new_data)

      lines = File.readlines(filename)
      line = lines[line_id]
      res = line.split(',')
      res[index] = new_data
      res = res.join(',')

      File.open(filename, 'w') do |f|
         id = 0
         lines.each { |ln|
            if id == line_id
               f.puts res
            else
               id += 1
               f.puts ln
            end
         }

      end

   end

   # Reads a line from a file
   def read_line(filename, line_id)

      lines = File.readlines(filename)
      return lines[line_id]

   end

   # Appends a line to a file
   def add_line(filename, line)

      File.open(filename, 'a') do |f|
         f.puts line
      end

   end

end

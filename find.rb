require "find" # to use command-line "find" to go through subdirectories for files
require "open3" # to run ImageMagick's convert from our script
require "fileutils" # file-handling tools

# loop do
  puts "[Exit] Exit"
  puts "Enter the extension format of the file: "
  @format_file = gets().chomp()
  puts "Enter the file to search(.#{@format_file}) : "
  @filename = gets().chomp()
  @current_path = ""

  if @filename.eql?("Exit")
    exit
  end

  sty_file_paths = []
  found_sty_file_paths = []

  found = 0;

  puts "\n\nSearching..."

  Dir.glob("**/").select { |f|
    if File.directory? f
      if Dir["#{f}/*.{#{@format_file}}"]
        Find.find(f) do |path|
          sty_file_paths << path
       
          @current_path = path
        end
           system 'cls'
 puts "\n\nSearching: #{f}"
      end
    end
  }

  


  if sty_file_paths.size > 0
    sty_file_paths.each do |file|
      if File.basename(file).include?(@filename)
        found_sty_file_paths << File.absolute_path(file) if !found_sty_file_paths.include?(File.absolute_path(file))
        # puts "Found in #{File.absolute_path(file)}"
        found = 1;
      end
    end
  end
  if found.eql? 0
    puts "***********No items match your search.***********."
  else
    system 'cls'
    puts "\n\n***********Done Searching!***********"
    puts "\n\n***********Found #{found_sty_file_paths.size} #{@filename} files***********"
    puts "\n\n***********Created FOUND_LIST.txt***********\n***********Located at:#{Dir.pwd}***********"
    found_txt = File.new("FOUND_LIST.txt", "w")
    found_txt.puts(found_sty_file_paths)
    found_txt.close
  end

#   break if File.extname(@filename).eql?(".#{@format_file}")
# end


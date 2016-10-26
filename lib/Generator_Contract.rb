require 'erb'

def read_data_file readable_file
  @data   = File.readlines readable_file
  $data = {}
  name_line = [:city, :time, :the_purchasers_name, :sellers_name, :enterprise_name]

  @data.each_with_index do |line, count|
    $data[name_line[count]] = line
    count+=1
  end
  sending_to_create
end

def sending_to_create
  erb_file = ("#{File.dirname(__FILE__)}/Generator/HTML/contract of sale/form.html.erb")
  css_file = ("#{File.dirname(__FILE__)}/Generator/HTML/contract of sale/stylesheet.css")
  craate_file erb_file, "html"
  craate_file css_file, "css"
end

def craate_file file_path, file_extension
  read_file = File.read(file_path)
  renderer = ERB.new(read_file)

  result = renderer.result(binding)

  File.open("#{File.dirname(__FILE__)}/../Contract."+file_extension, "w") do |f|
    f.write(result)
  end
end

read_data_file(*ARGV.map)

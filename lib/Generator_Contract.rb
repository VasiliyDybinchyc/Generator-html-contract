require 'erb'
module ContractOfSale
  class Generator_Contract

    def initialize (readable_file)
      data   = File.readlines readable_file
      @hash_data = {}
      name_line = [:city, :time, :the_purchasers_name, :sellers_name, :enterprise_name]

      data.each_with_index do |line, count|
        @hash_data[name_line[count]] = line
        count+=1
      end
      sending_to_create
    end

    def sending_to_create
      erb_file = ("#{File.dirname(__FILE__)}/Generator/HTML/contract of sale/form.html.erb")
      css_file = ("#{File.dirname(__FILE__)}/Generator/HTML/contract of sale/stylesheet.css")
      create_file erb_file, "html"
      create_file css_file, "css"
      p "Files create in #{Dir.pwd}"
    end

    def create_file file_path, file_extension
      file = File.read(file_path)

      renderer = ERB.new(file).result(binding)

      File.open("#{File.dirname(__FILE__)}/../Contract."+file_extension, "w") do |f|
        f.write(renderer)
      end
    end

  end
end

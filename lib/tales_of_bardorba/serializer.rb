module TalesOfBardorba
  class Serializer
    def initialize(object)
      @object = object
    end

    attr_reader :object

    def save(file)
      File.open(file, "w") do |f|
        object.instance_variables.each do |name|
          value = object.instance_variable_get(name)
          f.puts "#{name}=#{serialize_value(value)}"
        end
      end
    end

    def serialize_value(value)
      if value.is_a?(String)
        "\"#{value.lines.count}:#{value}"
      else
        value.to_s
      end
    end

    def load(file, header = nil)
      File.open(file) do |f|
        skip_to(header, f)
        while (line = f.gets)
          return unless line.include?("=")
          data = line.split("=")
          object.instance_variable_set("@#{data[0]}", parse_value(data[1], f))
        end
      end
    end

    def skip_to(header, file)
      if header
        until file.gets.strip == header
          # do nothing:  just skipping lines
        end
      end
    end

    def parse_value(serialized_value, file)
      case serialized_value
      when /\A"(\d+):(.*)\z/m then parse_string($1.to_i, $2, file)
      when /\A(true|false)\Z/ then $1 == "true"
      when /\Anil\Z/          then nil
      when /\A(\d+\.\d+)\Z/   then $1.to_f
      when /\A(\d+)\Z/        then $1.to_i
      end
    end

    def parse_string(line_count, first_line, file)
      string = first_line
      (line_count - 1).times do
        string << file.gets
      end
      string.chomp
    end
  end
end

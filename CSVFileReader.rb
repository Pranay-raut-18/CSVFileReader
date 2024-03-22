require 'csv'

class CSVFileReader
  def initialize(data = {}) #empty Hash
    @data = data
  end

  #predefined method method, which is called when an undefined method is invoked on an instance of the class
  def method_missing(method_name, *args, &block) 
    string_method = method_name.to_s
    if string_method.end_with?('=')
      attr_name = string_method.chomp('=').to_sym
      @data[attr_name] = args.first
      save_data
    elsif @data.key?(string_method.to_sym)
      @data[string_method.to_sym]
    else
      super #no method error
    end
  end

  def respond_to_missing?(method_name, include_private = false) #misssing method have to be responded
    @data.key?(method_name.to_s.chomp('=').to_sym) || super
  end

  def self.csv_file_path
    "#{name.downcase}s.csv"
  end

  def self.find_by(attribute, value) 
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
      if row[attribute.to_sym].to_s == value.to_s
        return new(row.to_h)
      end
    end
    nil
  end

  def save_data  #saving the ddata 01 add  02 merge 02 create a uniq
    existing_data, existing_headers = read_existing_csv_data
    updated_headers = (existing_headers | @data.keys.map(&:to_s)).uniq  

    identifier_key = @data.keys.first.to_s  
    record_index = existing_data.index { |row| row[identifier_key] == @data[identifier_key.to_sym].to_s }
       
    if record_index.nil?
      existing_data << @data.transform_keys(&:to_s)
    else
      existing_data[record_index].merge!(@data.transform_keys(&:to_s))
    end
    CSV.open(self.class.csv_file_path, 'w', write_headers: true, headers: updated_headers) do |csv|
      existing_data.each do |row|
        csv << updated_headers.map { |header| row.fetch(header, nil) }
      end
    end
  end

  private

  def read_existing_csv_data   #Reading the existing data 
    file_path = self.class.csv_file_path
    return [[], []] unless File.exist?(file_path) && !File.zero?(file_path)
       
    existing_data = CSV.read(file_path, headers: true).map(&:to_hash)
    existing_headers = existing_data.first&.keys || []
    [existing_data, existing_headers]
  end
end

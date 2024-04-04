require 'csv'

class CSVFileReader
  def self.inherited(subclass)
    subclass.instance_variable_set(:@csv_filename, "#{subclass.to_s.downcase}s.csv")
    subclass.instance_variable_set(:@attributes, [])
    
    # Read the header row of the CSV file to determine attributes
    CSV.foreach(subclass.instance_variable_get(:@csv_filename), headers: true) do |row|
      subclass.instance_variable_set(:@attributes, row.headers)
      break
    end
    
    # Define attribute accessor methods for each column in the CSV file
    subclass.instance_variable_get(:@attributes).each do |attribute|
      subclass.class_eval do
        attr_accessor attribute.to_sym
      end
    end
  end
  
  def self.find_by(attribute, value)
    data = CSV.read(@csv_filename, headers: true)
    row = data.find { |row| row[attribute] == value.to_s }
    
    if row
      obj = self.new
      @attributes.each do |attr|
        obj.send("#{attr}=", row[attr])
      end
      obj
    else
      nil
    end
  end
end





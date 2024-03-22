require 'csv'

state=[
    ["name","capital","population"],
    ["Karnataka","bangalore","6crore"],
    ["Tamilnadu","chennai","7crore"],
    ["Maharastra","mumbai","10crore"]

]


path='states.csv'
CSV.open(path,'w') do |data|
    state.each do |row|
        data << row
    end
end
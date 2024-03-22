require_relative "CSVFileReader"
class State < CSVFileReader 
end
 

st = State.new
st.name = "Bihar"
st.capital = "Patna"
st.population = "22Crore"
 
st1 = State.find_by("name", "Karnataka")
puts st1.capital # this should print Bangalore 
puts st1.population # this should print 6crore
 

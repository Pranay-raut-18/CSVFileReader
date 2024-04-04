require_relative "CSVFileReader"

class Student < CSVFileReader
end

class State < CSVFileReader
end

st = State.new
st.name = "Bihar"
st.capital = "Patna"
st.population = "22Crore"
# p st
st1 = State.find_by("name", "Tamilnadu")
puts st1.capital 
puts st1.population 

s = Student.new
s.student_id = 10
s.student_name = "Amit"
s.teacher_name = "Shilesh"
s.subject = "Physics"
# p s;

s1 = Student.find_by("student_id", 1)
puts s1.student_name 
puts s1.teacher_name 

obj = State.new
# p obj

require_relative 'CSVFileReader'

class Student < CSVFileReader
end
 
s = Student.new
s.student_id = 13
s.student_name = "Akhil"
s.teacher_name = "Shilesh"
s.subject = "Physics"
 
s1 = Student.find_by("student_id", 3)
puts s1.student_name # this should print kiran 
puts s1.teacher_name # this should print manoj

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print_students(students)
  counter = 0
  while counter < students.length
    puts "#{counter + 1}. #{students[counter][:name]}, their hobby is: #{students[counter][:hobby]} (#{students[counter][:cohort]} cohort)".center(100)
    counter += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(100)
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty?
    puts "What is #{name}'s hobby: "
    hobby = retrieve_response
    puts "And which cohort do they belong to (just hit return if you dont know): "
    cohort = retrieve_response
    cohort = :november if cohort == nil
    students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def retrieve_response
  response = gets.chomp
  puts "type yes to confirm, or no to start again"
  yes_or_no_response = gets.chomp
  if yes_or_no_response == "yes"
    return response
  else
    retrieve_response.to_sym
  end
end
# def input_letter
#   puts "Please enter the letter of students you would like to see: "
#   input = gets.chomp
#   input[0]
# end

students = input_students
print_header
# letter = input_letter
print_students(students)
print_footer(students)

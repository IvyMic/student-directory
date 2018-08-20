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
    cohort = :november if cohort == ""
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

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print_students(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu

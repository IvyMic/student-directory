@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    puts "Please input new students"
    sleep(1)
    input_students
  when "2"
    puts "Showing students"
    sleep(1)
    show_students
  when "9"
    puts "Exiting..."
    sleep(3)
    exit # this will cause the program to terminate
  when "3"
    puts "Saving students"
    sleep(1)
    save_students
    puts "File saved!"
  when "4"
    filename = retrieve_filename
    if File.exists?(filename) == false
      puts "file not found0"
      return
    end
    puts "Loading students..."
    sleep(2)
    load_students(filename)
    puts "Students loaded. choose show students option to show them"
  else
    puts "I don't know what you meant, try again"
  end
end

def retrieve_filename
  puts "Enter file name of students you would like to load:"
  filename = gets.chomp
  filename = "#{filename}.csv"
  filename
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "What is #{name}'s hobby:"
    hobby = retrieve_response
    puts "And which cohort do they belong to (just hit return if you dont know): "
    cohort = retrieve_response
    cohort = cohort.to_sym
    cohort = :november if cohort.empty?
    # add the student hash to the array
    add_hash_to_students({name: name, cohort: cohort, hobby: hobby})
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_hash_to_students(hash)
  @students << hash
end

def retrieve_response
  response = STDIN.gets.chomp
  puts "type yes to confirm, or no to type it again"
  yes_or_no_response = STDIN.gets.chomp
  if yes_or_no_response == "yes"
    return response
  else
    retrieve_response
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print_student_list
  counter = 0
  while counter < @students.length
    puts "#{counter + 1}. #{@students[counter][:name]}, their hobby is: #{@students[counter][:hobby]} (#{@students[counter][:cohort]} cohort)".center(100)
    counter += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(100)
end

def save_students
  # open the file for writing
  puts "What shall you name the file (dont type the extension, just the file name)"
  filename = retrieve_response
  filename = filename.gsub(/\s+/, "")
  file = File.open("#{filename}.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby = line.chomp.split(',')
    add_hash_to_students({name: name, cohort: cohort.to_sym, hobby: hobby})
  end
  file.close
end

def try_load_students
  filename = ARGV.first# first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu

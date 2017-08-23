@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

# ex5. add more info.
def input_students_more
  # create an empty array
  while true
    # get student info.
    puts "Please create a student record"
    puts "To finish, just hit return twice"
    # get student name
    name = ""
    while name.empty?
      puts "Please enter the name of the student"
      name = gets.chomp
    end
    # ex7. Get student cohort
    months = [[1, :Jan],
              [2, :Feb],
              [3, :Mar],
              [4, :Apr],
              [5, :May],
              [6, :Jun],
              [7, :Jul],
              [8, :Aug],
              [9, :Sep],
              [10, :Oct],
              [11, :Nov],
              [12, :Dec]
            ]
    puts "Please enter #{name}'s cohort (in number)"
    cohort_s = gets.chomp
    if cohort_s.empty? == true
      t = Time.new
      cohort_i = t.month
      puts "Cohort will be set as the current month"
    else
      cohort_i = cohort_s.to_i
    end

    while (cohort_i >= 1 && cohort_i <= 12) == false
      puts "Please enter a number between 1 and 12"
      cohort_i = (gets.chomp.to_i)
    end

    # why do I need to assign soemthing to cohort here first?
    cohort = ''
    months.each do |month|
      if month[0] == cohort_i
        # why I can't assign soemthing to cohort here?
        cohort = month[1]
      end
    end

    # ex5. Get other student info
    puts "What's #{name}'s country of birth?"
    country = gets.chomp
    puts "What's #{name}'s height? (cm)"
    height = gets.chomp
    puts "What's #{name}'s favourite hobby?"
    hobby = gets.chomp
    # put student info into array
    @students << {name: name, cohort: cohort, country: country, height: height, hobby: hobby}
    # ex9. student number
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # answer yes to get another record, no to return array
    puts "Would you like to create another student record? (yes/no)"
    more = gets.chomp
    while (more.downcase != "yes") && (more.downcase != "no")
      puts "Please answer 'yes' or 'no'"
      more = gets.chomp
    end

    if more.downcase == "no"
      return @students
    end
  end
end

# ex8. print by cohorts
def print_by_cohort(students)
  # ex10. check student count
  if students.count == 0
    puts "There is no student in the directory!"
  else
    months = [[1, :Jan],
              [2, :Feb],
              [3, :Mar],
              [4, :Apr],
              [5, :May],
              [6, :Jun],
              [7, :Jul],
              [8, :Aug],
              [9, :Sep],
              [10, :Oct],
              [11, :Nov],
              [12, :Dec]
            ]
    months.each do |month|
      students.each do |student|
        if student[:cohort] == month[1]
          puts "#{student[:name]} (#{student[:cohort]} cohort) "
               "Country: #{student[:country]} Height: #{student[:height]} "
               "Hobby: #{student[:hobby]}"
        end
      end
    end
  end
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort) "
         "Country: #{student[:country]} Height: #{student[:height]} "
         "Hobby: #{student[:hobby]}"
  end
end

# ex2. only print the students whose name begins with a specific letter.
def print_initial(students)
  puts "What's the first letter?"
  letter = gets.chomp
  students.each_with_index do |student, index|
    if student[:name].chr.downcase == letter
    puts "#{index +1} #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

# ex4. while.
def print_while(students)
  count = 1
  while count <= students.length
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
    count += 1
  end
end

# ex4. until.
def print_until(students)
  count = 1
  until count > students.length
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
    count += 1
  end
end

# ex6. print header - center
def print_header
  line_width = 70
  puts ("The students of Villains Academy".center(line_width))
  puts ("-------------".center(line_width))
end

def print_footer
  # ex10. check student count
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  elsif @students.count == 1
    puts "Overall, we have 1 great student"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
    when "1"
      input_students_more
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu

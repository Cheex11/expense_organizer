require './lib/expense'
require 'pg'
require 'pry'


DB = PG.connect({:dbname => 'expense_organizer'})

system "clear"

def main_menu
  puts 'Hello user'
  puts 'Would you like to add an expense or view expenses?'
  puts 'Type "add" to add an expense or "view" to view expenses'
  puts 'Type "exit" to exit the program'

  case gets.chomp
  when 'add'
    add_expense_ui
  when 'view'
    view_expenses_ui
  when 'exit'
    'goodbye'
    exit
  else
    'please try again'
    main_menu
  end
  main_menu
end

def add_expense_ui
  puts "So, spending dem bills, aye????"
  puts "Please enter a name for your expense"
  description = gets.chomp
  puts "Got it! Wow, spending money on a silly thing like #{description} ??"
  puts "Okay, whatevs, now enter the amount...."
  amount = gets.chomp.to_f
  puts "Did you make this purchase today? Press Y or N"
  date_in_question = gets.chomp.upcase
  case date_in_question
    when 'Y'
      date = Time.now.strftime("%Y/%m/%d")
    when 'N'
      puts "Please enter the day of your purchase in year-month-day format"
      date = gets.chomp
  end
  puts "Got it!"
  new_expense = Expense.create({:amount => amount, :description => description, :date => date})
#  binding.pry
  puts "Expense has been saved to the database!"
  # ATTENTION! We started to do this but ran out of time!
  # Need to create join files first
  # puts "Please type a category to assign this expense to:"
  # chosen_category = gets.chomp
  # Category.all each do |category|
  #   if category.cat_name == chosen_category


  gets.chomp
  main_menu
end

def view_expenses_ui
  system "clear"
  puts "Here are all of your expenses:\n"
  results = Expense.all.each do |expense|
    description = expense.description
    amount = expense.amount
    date = expense.date
    puts "\n#{description} was purchased on #{date} and cost $#{amount}0\n"
  end
  gets.chomp
  main_menu
end

main_menu

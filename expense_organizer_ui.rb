require './lib/expense'
require './lib/category'
require 'pg'
require 'rspec'
require 'pry'


DB = PG.connect({:dbname => 'expense_organizer'})

system "clear"

def main_menu
  puts 'Hello user'
  puts 'Would you like to add an expense or view expenses?'
  puts 'Type "add" to add an expense or "view" to view expenses'
  puts 'Type "view catz" to view expenses for a particular category'
  puts 'Type "percent" to see your percentage of expenses'
  puts 'Type "exit" to exit the program'

  case gets.chomp
  when 'add'
    add_expense_ui
  when 'view'
    view_expenses_ui
  when 'view catz'
    view_catz_ui
  when 'percent'
    view_percent
  when 'exit'
    'goodbye'
    exit
  else
    'please try again'
    main_menu
  end
end

def view_catz_ui
  Category.all.each do |category|
    puts "#{category.cat_name}"
  end

  puts "What category would you like to see expenses for?"
  input_category = gets.chomp

  results = []

  Category.all.each do |category|
    if category.cat_name == input_category
      puts "should only appear once"
      results << category.find_expenses
    end
  end

  # results.each do |result|
  #   puts "For expense: #{result['description']} you spent #{result['amount']} on  #{result['date']}"
  # end
  # sleep(4)
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
      date = Date.today
    when 'N'
      puts "Please enter the day of your purchase in year-month-day format"
      date = gets.chomp
  end
  puts "Got it!"
  new_expense = Expense.create({:amount => amount, :description => description, :date => date})
  puts "Please type a category to assign this expense to:"
  chosen_category = gets.chomp
  current_cat = []
  Category.all.each do |category|
    if category.cat_name == chosen_category
      current_cat << category
    end
  end
  if current_cat == []
    new_cat = Category.create(chosen_category)
    new_cat.add_expense(new_expense.id)
  else
    current_cat[0].add_expense(new_expense.id)
  end
  puts "\e[5;34mExpense has been saved to ye database matey!\e[0m"
  gets.chomp
  main_menu
end

def view_expenses_ui
  system "clear"
  puts "Here are all of your expenses:\n"
  results = Expense.all.each do |expense|
    puts "\n#{expense.description} was purchased on #{expense.date} and cost $#{expense.amount}0\n"
  end
  gets.chomp
  main_menu
end

def view_expenses_ui
  system "clear"
  puts "Here are all of your expenses in percents for categories:\n"

  gets.chomp
  main_menu
end

main_menu

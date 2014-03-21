require './lib/expense'
require 'pg'


DB = PG.connect({:dbname => 'expense_organizer'})

def main_menu
  puts 'Hello user'
  puts 'Would you like to add an expense or view expenses?'
  puts 'Type "add" to add an expense or "view" to view expenses'

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







main_menu

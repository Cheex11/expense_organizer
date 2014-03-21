#SPEC
require 'spec_helper'


describe Expense do
  describe 'initialize' do
    it 'is a new instance of an expense' do
      test_expense = Expense.new({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense.should be_an_instance_of Expense
    end
    it 'is initialized with a dollar amount, description, and date' do
      test_expense = Expense.new({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense.amount.should eq 2.55
    end
  end

  describe '.all' do
    it 'starts off with no expenses' do
      Expense.all.should eq []
    end
  end
  describe 'save' do
    it 'stores each instance of an expense in the database' do
      test_expense = Expense.new({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense.save
      Expense.all.should eq [test_expense]
    end
  end
  describe '.create' do
    it 'initializes and saves a new instance of an expense' do
      test_expense = Expense.create({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense.description.should eq 'coffee'
    end
  end

  describe '==' do
    it 'it is the same expense if it has the same information but a different id' do
      test_expense = Expense.new({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense.save
      Expense.all.should eq [test_expense]
    end
  end

end

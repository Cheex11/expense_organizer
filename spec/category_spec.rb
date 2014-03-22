require 'spec_helper'

describe 'Category' do
  it 'initializes a new instance of category' do
    test_category = Category.new("Fun")
    test_category.should be_an_instance_of Category
  end
  describe '.all' do
    it 'starts with an empty array' do
      Category.all.should eq []
    end
  end
  describe 'save' do
    it 'saves an instance of a category to the datatbase' do
      test_category = Category.new("Fun")
      test_category.save
      Category.all.should eq [test_category]
    end
  end

  describe '==(another_category)' do
    it 'is the same category if it has the same name' do
      test_category = Category.new("Fun")
      test_category2 = Category.new("Fun")
      test_category.should eq test_category2
    end
  end

  describe '.create' do
    it 'creates and saves an instance of a category' do
      test_category = Category.create("Fun")
      Category.all.should eq [test_category]
      test_category.cat_name.should eq "Fun"
    end
  end

  describe '#add_expenses' do
    it 'adds to the join table the expense matching the category' do
      test_category = Category.create("Fun")
      test_expense = Expense.create({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_category.add_expense(test_expense.id)
      test_category.list_exp_cat.should eq ['coffee']
    end
  end

  describe '#total_amount_spent' do
    it 'returns the total amount for all expenses in a category' do
      test_category = Category.create("Fun")
      test_expense1 = Expense.create({ :amount => 2.55, :description => 'coffee', :date => '2014-03-21' })
      test_expense2 = Expense.create({ :amount => 5.46, :description => 'apples', :date => '2014-03-21' })
      test_category.add_expense(test_expense1.id)
      test_category.add_expense(test_expense2.id)
      test_category.total_amount_spent.should eq 8.01
    end
  end

  describe 'find_expenses' do
    it 'returns all expenses for selected category' do
      test_category = Category.create("Nightlife")
      test_expense = Expense.create({ :amount => 22.00, :description => 'vodka', :date => '2014-03-21' })
      test_expense1 = Expense.create({ :amount => 22.00, :description => 'jager', :date => '2014-03-21' })
      test_category.add_expense(test_expense.id)
      test_category.add_expense(test_expense1.id)
      test_category.find_expenses[0]['description'].should eq 'vodka'
      test_category.find_expenses[1]['description'].should eq 'jager'
    end
  end
end


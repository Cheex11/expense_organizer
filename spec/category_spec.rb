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
end


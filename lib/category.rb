class Category
  attr_reader :cat_name, :id, :results

  def initialize(cat_name, id=nil)
    @cat_name = cat_name
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM categories;")
    results.map do |result|
      Category.new(result['category'], result['id'].to_i)
    end
  end

  def save
    results = DB.exec("INSERT INTO categories (category) VALUES ('#{@cat_name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_category)
    self.cat_name == another_category.cat_name
  end

  def self.create(cat_name, id = nil)
    new_category = Category.new(cat_name, id)
    new_category.save
    new_category
  end

  def add_expense(expense_id)
    DB.exec("INSERT INTO expenses_cats (expense_id, cat_id) VALUES (#{expense_id}, #{@id});")
  end

  def list_exp_cat
    results = DB.exec("SELECT expenses.description FROM expenses
                       INNER JOIN expenses_cats
                       ON expenses.id = expenses_cats.expense_id
                       WHERE expenses_cats.cat_id = #{self.id};")
    results.map do |result|
       result['description']
    end
  end

  def total_amount_spent
    results = DB.exec("SELECT expenses.amount FROM expenses
                       INNER JOIN expenses_cats
                       ON expenses.id = expenses_cats.expense_id
                       WHERE expenses_cats.cat_id = #{self.id};")
    total_amount = 0
    results.each do |result|
      total_amount += result['amount'].to_f
    end
    total_amount
  end

  def find_expenses
    results = DB.exec("SELECT expenses.* FROM
                      categories join expenses_cats on (categories.id = expenses_cats.cat_id)
                                 join expenses on (expenses_cats.expense_id = expenses.id)
                      where categories.id = #{@id};")
    results

  end
end

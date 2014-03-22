class Expense

  attr_reader :amount, :description, :date, :id

  def initialize(attributes)
    @amount = attributes[:amount]
    @description = attributes[:description]
    @date = attributes[:date]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM expenses;")
    results.map do |result|
      Expense.new({:amount => result['amount'].to_f,
                   :description => result['description'],
                   :date => result['date'],
                   :id => result['id'].to_i})
    end
  end

  def save
    result = DB.exec("INSERT INTO expenses (amount, description, date)
                      VALUES ('#{@amount}', '#{@description}', '#{@date}')
                      RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.create(attributes)
    new_expense = Expense.new(attributes)
    new_expense.save
    new_expense
  end

  def ==(another_expense)
    self.description == another_expense.description
    self.amount == another_expense.amount
    self.date == another_expense.date
  end

end

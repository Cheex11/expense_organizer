class Category
  attr_reader :cat_name, :id

  def initialize(cat_name, id=nil)
    @cat_name = cat_name
    @id = id
  end

  def self.all
    @categories = []
    results = DB.exec("SELECT * FROM categories")
    results.each do |result|
      cat_name = result['category']
      id = result['id'].to_i
      @categories << Category.new(cat_name, id)
    end
    @categories
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
end

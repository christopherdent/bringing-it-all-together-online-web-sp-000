require 'pry'
class Dog
attr_accessor :name, :breed
attr_reader :id
 
  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
  
  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT, 
      breed TEXT 
      );
    SQL
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql = <<-SQL 
      DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end 
  
  
  def save 
  
    sql = <<-SQL 
      INSERT INTO dogs (name, breed) 
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    #binding.pry
    self
  end 
  
  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save
    dog
  end
    
  def self.new_from_db(row)
    new_dog = self.new(id: row[0], name: row[1], breed: row[2])   
    new_dog 
  end 

  def self.find_by_id(id)
    sql = <<-SQL 
      SELECT * FROM dogs
      WHERE id = ?
      LIMIT 1 
    SQL
    result = DB[:conn].execute(sql, id)[0]
    Dog.new(id: result[0], name: result[1], breed: result[2])
    
  end 
   
  def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    
  end 

    
  
end 
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
    
  def self.new_from_db
    
  end 
  
  
  
  
  
  
  
  
  def self.find_by_id(id)
    sql = <<-SQL 
      SELECT * FROM pokemon
      WHERE id = ?
      LIMIT 1 
    SQL
      
    DB[:conn].execute(sql, id).map {|row| self.new(id: row[0], name: row[1], type: row[2], db: db)}.first  
    
  end 
   
  def self.find_or_create_by
    
  end 

    
  
end 
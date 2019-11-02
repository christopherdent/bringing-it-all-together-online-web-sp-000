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
    dog = Dog.new(name:, breed:)
    dog.save
    dog
  end
    
    
      describe ".create" do
    it 'takes in a hash of attributes and uses metaprogramming to create a new dog object. Then it uses the #save method to save that dog to the database'do
      Dog.create(name: "Ralph", breed: "lab")
      expect(DB[:conn].execute("SELECT * FROM dogs")).to eq([[1, "Ralph", "lab"]])
    end
    it 'returns a new dog object' do
      dog = Dog.create(name: "Dave", breed: "podle")

      expect(teddy).to be_an_instance_of(Dog)
      expect(dog.name).to eq("Dave")
    end
  end
    
   

    
  
end 
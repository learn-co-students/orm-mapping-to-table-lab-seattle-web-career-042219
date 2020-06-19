require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students
      (ID INTEGER PRIMARY KEY,
        NAME TEXT,
        GRADE TEXT)
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL

      DB[:conn].execute(sql)
  end

  def save
    sql =<<-SQL
      INSERT INTO students(name, grade) Values(?, ?)
      SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #binding.pry
  end

  def self.create(attr_hash)
    new_student = Student.new(attr_hash[:name], attr_hash[:grade])
    #binding.pry
    new_student.save
    new_student
  end


end

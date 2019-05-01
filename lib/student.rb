
class Student
attr_accessor :name, :grade
attr_reader :id

def initialize(name, grade)
  @name = name
  @grade = grade
end

def self.create_table
  sql = "CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)
    "
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = "DROP TABLE students"
  DB[:conn].execute(sql)
end

def save
  sql = <<-SQL
  INSERT INTO students(name, grade)
  VALUES(?,?)
  SQL
  DB[:conn].execute(sql,name,grade)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

def self.create(name:, grade:)
  @name = name
  @grade = grade
  new_student =self.new(@name, @grade)
  new_student.save
  new_student
end
end

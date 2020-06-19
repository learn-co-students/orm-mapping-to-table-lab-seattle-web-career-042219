class Student
  attr_accessor :name, :grade
  @@all = []

  def id
    sql = <<-SQL
    SELECT id
    FROM students
    WHERE name = ?;
    SQL
    DB[:conn].execute(sql, name).flatten[0]
  end

  def initialize(name, grade)
    @name = name
    @grade = grade
    @@all << self
  end

  def self.create_table
    DB[:conn].execute <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT);
    SQL
  end

  def self.drop_table
    DB[:conn].execute <<-SQL
      DROP TABLE students
    SQL
  end

  def save
    sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, name, grade)
    @id
  end

  def self.create(hash)
    name = hash[:name]
    grade = hash[:grade]
    new_student = new(name, grade)
    new_student.save
    new_student
  end
end

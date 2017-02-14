

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
  	@name = name
  	@grade = grade
  	@id = nil
  end

  def self.create_table
  	sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER)
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
  	sql = <<-SQL
		INSERT INTO students (name, grade)
		VALUES (?, ?)
  		SQL

  	sql_id = <<-SQL
		SELECT last_insert_rowid() FROM students
  		SQL

    DB[:conn].execute(sql, @name, @grade)
  	@id = DB[:conn].execute(sql_id)[0][0]
  		
  end

  def self.create(name:, grade:)
  	student = Student.new(name, grade)
  	student.save
  	student
  end

end
